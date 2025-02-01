### 4. Considere o programa oops que executa com privilégios de superuser e é composto pelo seguinte código-fonte:

```c
void imprime(char *s) {
	char buf[64];
	strncpy(buf, s, 64);
	buf[63] = ‘\0’;
	printf(buf);
}

int main(int argc, char **argv){
	imprime(argv[1]);
	return 0;
} 
```

#### a) Identifique a vulnerabilidade presente neste programa e explique como é que poderia ser explorada por um atacante para ler o conteúdo de endereços de memória arbitrários.

- Trata-se de uma vulnerabilidade de format strings, pois o programa usa a própria string que foi dada pelo utilizador como primeiro argumento da função `printf`, podendo ser possível usar uma format string, que permitiria a leitura e escrita dos registos `rsi`, `rcx`, `rdx`, `r8`, `r9` e posteriormente conteúdos do stack, através de format strings como `%x`, `%s` ou `%n`

#### b) Como é que uma ferramenta de análise de fluxo de dados (e.g., CQual) processaria o programa oops e detectaria a vulnerabilidade identificada na alínea a)?

- Usaria uma taint analysis approach: seguia o input do utilizador desde `argv[1]` até ser usado conteúdo de `buf` (com esse input, logo tainted), num `printf` que pode ser usado como format string, gerando um alerta para o mesmo.

#### c) Apresente uma versão corrigida do programa oops que não contenha a vulnerabilidade identificada na alínea a).

- Solução que garante que os conteúdos de `buf` é interpretado apenas como string e não como format string:
```c
// ...
printf("%s", buf);
// ...
```

### 5. Compare os ataques de heap overflow e stack overflow em termos de facilidade de execução e danos potenciais.

- Heap overflow:
	- Mais difícil de conseguir arbitrary code execution, pois requeria dar overwrite de um function pointer no heap
	- Danos potenciais: permite a leitura e corrupção de dados 
- Stack overflow:
	- Mais fácil de conseguir isso através do overwrite do return address (RIP) da função guardado no stack frame
	- Danos potenciais: execução de código arbitrário

#### 6. Descreva os quatro principais tipos de vulnerabilidades de inteiros.

- Integer overflow
- Integer underflow
- Integer signedness
- Integer truncation

### 9. Considere uma aplicação web desenvolvida em Java que utiliza um determinado SGBD e que é acedida pelos utilizadores via browser. Dado que os comandos SQL enviados ao SGBD incluem parâmetros especificados pelo utilizador, esta aplicação inclui potencialmente vulnerabilidades de injeção de SQL. Das seguintes afirmações, indique a única que é verdadeira:

- É difícil explorar este tipo de vulnerabilidade se os comandos SQL forem produzidos pelo código Java da aplicação Web usando **queries parametrizadas.**
	- É uma prática segura que ajuda a evitar SQL injections, pois os parâmetros fornecidos pelo usuário são tratados como dados e não como parte da consulta SQL, impedindo que um atacante injete código SQL malicioso

### 10. Identifique e descreva dois mecanismos de injecção de SQL de primeira ordem e explique o que se entende por injecção de segunda ordem

- **Injeção de SQL de primeira ordem**: o atacante insere diretamente código malicioso no input do utilizador, afetando imediatamente o query SQL
- **Injeção de SQL de segunda ordem**: o código malicioso é injetado no sistema (BD, ficheiro, ...) e a execução do código ocorre num query subsequente

### 11. Considere o programa ooops que executa com privilégios de superuser e é composto pelo seguinte código-fonte:

```c
#include <stdio.h>
#include <unistd.h>
#include <sys/stat.h>

void escreve(char *file) {
    FILE *f;
    struct stat statb;
    if (!lstat(file, &statb)){
        if (S_ISREG(statb.st_mode)) {
            f = fopen(file, "wb+");
            fwrite("ola", 3, 1, f);
            fclose(f);
        }
        else {
            fprintf(stderr, "Erro: %s eh um link.", file);
        }
    }
    else {
        fprintf(stderr, "Erro ao obter informacao.");
    }
}

int main(int argc, char **argv){
    escreve(argv[1]);
    return 0;
}
```

#### a) Identifique a vulnerabilidade presente neste programa e explique como é que poderia ser explorada por um atacante para corromper um ficheiro arbitrário.

- Este programa é vulnerável a um **race condition attack**, mais especificamente, a um **symbolic link attack**
- O programa não verifica se o arquivo fornecido é um **symlink** antes de abri-lo com `fopen`
- **Exploração:**
	- Um atacante pode criar um symlink que aponta para um ficheiro crítico, como `/etc/passwd`. Ao passar esse symlink para o programa, ele reescreve o conteúdo do ficheiro alvo com "ola", corrompendo-o. Como o programa é executado com privilégios de superuser, o atacante pode afetar qualquer ficheiro no sistema
	- A corrida acontece entre o momento em que o programa verifica a existência do ficheiro e o momento em que o atacante pode modificar o symlink para redirecionar a escrita para um ficheiro sensível

#### b) Explique como é que poderia ser corrigida a vulnerabilidade identificada.

- Devemos usar file descriptors
```c
//...
int fd = open(file, O_WRONLY | O_CREAT | O_TRUNC | O_NOFOLLOW, 0644);
if (fd == -1) {
	/* error */
} else {
	write(fd, "ola", 3);
	close(fd);
}
// ...
```

