### 1. Compare os ataques de overflow na heap e overflow na pilha em termos de facilidade de exploração e danos potenciais.

- **Heap overflows:**
	- Mais difícil de explorar devido à alocação dinâmica de memória
	- Permitem obter ou alterar memória alocada no heap
	- Permite execução de código arbitrário mas é mais complexo
- **Stack overflows:**
	- Mais fácil de explorar devido à previsibilidade da organização da memória no stack
	- Além de permitir observar e alterar memória, permitem também o redirecionamento da execução do programa facilmente, potencialmente execução de código arbitrário ao reescrever o endereço de retorno do stack frame

### 2. Considere um ataque que usa um overflow na heap para reescrever um apontador de função localizado na pilha (não no heap). Este apontador de função é usado mais tarde, fazendo o programa saltar para o endereço fornecido pelo atacante. Explique com detalhe como seria feito este ataque, i.e., como pode um overflow na heap ser utilizado para escrever um valor de 4 bytes num apontador de função armazenado na pilha.

1. Realizar o heap overflow ao ultrapassar os limites alocados e reescrever regiões de memória adjacentes até à localização do function pointer
2. Calcular o endereço do function pointer e reescrevê-lo no heap
3. Quando o programa for obter esse valor, vai usar o novo pointer, redirecionando o fluxo de execução do programa para o código do atacante

### 3. O excerto de código apresentado tem, pelo menos, uma vulnerabilidade de buffer overflow. Explique:

```c
#define BUFSIZE 40
void vulnerable(char *origem1, char *origem2){
    char destino[BUFSIZE];
    int erro = 0;
    if (strlen(origem1) < BUFSIZE)
        strcpy(destino, origem1);
    else erro++;

    if (strlen(origem1) + strlen(origem2) <= BUFSIZE)
        strcat(destino, origem2);
    else erro++;

    if (erro == 0)
        printf("Destino: %s\n", destino);
}

int main(int argc, char *argv[]){
    if (argc > 3)
        vulnerable(argv[1], argv[2]);
    return 0;
}
```

#### 3.1 Que parâmetro(s) pode(m) ser usado(s) para explorar a vulnerabilidade.

- `origem1` - deve ter tamanho `BUFSIZE - 1`
- `origem2` - deve ter tamanho > 1

#### 3.2 Qual é ou quais são as linhas vulneráveis.

```c
if (strlen(origem1) + strlen(origem2) <= BUFSIZE)
        strcat(destino, origem2);
```
- Aqui existe uma vulnerabilidade de buffer overflow, devido à má validação de bounds checking, permitindo que bytes sejam copiado já fora dos limites da alocação do buffer `destino`.
- Se a primeira operação já preencher todo o buffer `destino` após copiar os bytes de `origem1`, a simples adição de qualquer byte de `origem2` excederá os limites

#### 3.3 Como pode a exploração da vulnerabilidade ser feita exatamente.

- Exemplo:
	- Considerando:
		- `len(BUFSIZE)` = 4
		- `len(origem1)` = 3
		- `len(origem2)` = 1
	- Primeiro if: `3 < 4` => copia `origem1` para `destino` incluindo o `\0` => `destino` tem 4 bytes (cheio)
	- Segundo if:  `3 + 1` => concatena `origem2` a `destino` incluindo o `\0`, `destino` tem agora 6 bytes (overflow)
	- Mesmo com `<` em vez de `<=` na segunda condição, seria possível um buffer overflow by one, pois o null terminator continuaria a ser escrito fora dos limites

#### 3.4 Qual é o efeito do ataque.

- O efeito do ataque é derivado ao overwrite de memória, podendo potencialmente crashar o programa (denial of service) ou reescrever o return address permitindo execução arbitrária de código

### 4. Considere os quatro principais tipos de vulnerabilidades de inteiros e apresente para cada um deles:

#### 4.1 Definição.

- **Integer overflow:** quando uma conta aritmética excede o valor máximo de bits para o tipo
- **Integer underflow:** quando uma conta aritmética atinge para além do valor mínimo
- **Integer signedness:** quando um tipo com sinal é convertido para um tipo sem sinal (ou vice- versa)
- **Integer truncation:** quando apenas alguns dos bits de um inteiro são considerados numa operação


