# Backend Architecture

### Resources
- **Resources**: anything can be a resource identifier
- **Endpoints & Actions**

```
PUT /questions/{category_id} question
GET /questions/{category_id}/{question_id}
```

### Resource Management Styles
1. **Web Services** (function-based)
	- Example: `PUT /do_something payload`
	- **Characteristics**:
		- No structure, server-side actions
		- Large APIs, complex services
2. **Database Style**
	- Example: `POST /query payload`
	- **Characteristics**:
		- Queries mimic database operations
		- Ideal for storage services
3. **Pragmatic REST** (resource-oriented)
	- Example: `PUT /products/{id} payload`
	- **Characteristics**:
		- Hierarchical structure
		- Simple endpoints, ideal for microservices
	- **Pros**: logical, fast, easy to maintain
	- **Cons**: limited relationships, no complex queries
4. **Hypermedia**
	- Example: `POST /workflow step_data`
	- **Use case**: linked tasks
5. **Event-Driven APIs**
	- Example: `POST /new_post`
	- **Use case**: Event-response systems

### Best Practices for API Design
- **Correct vs. Incorrect API Structures**
	- **Incorrect**: function call with actions in query params
    ```
    POST /changeProductList.php?item=35&action=changeTitle&title=new_title
    ```
    
	- **Correct**: resource-based
    ```http
    GET /product_lists/7/items/35/
    ```

- **Stateless API Design**
	- Avoid state management on the server side

- **Managing Resources**
	- Example:
	
```
PUT /basket/items/{item_id}/props
DELETE /basket/items/{item_id}/props
```

- **Hierarchical vs. Flat Resource Management**
	- Flat Example:
    ```http
    PUT /forum/items/{item_id}
    ```
    
	- Hierarchical Example:
    ```http
    PUT /forum/items/{item_id}/discussion/{post_id}
    ```

### API Naming Conventions
- **Better naming practices**:
	- `/works/{work_id}` instead of `/work/{work_id}`
	- `/customer/{cust_id}/addresses` instead of `/addresses/{cust_id}`

### API Management
- **Why APIs are crucial**:
	- APIs are standalone products
	- Enable system and legacy integration
- **API Strategy**
	- API should be **stable** while front-end can change
	- Potential pay-per-use models

### API Ecosystem & Design
- **API Design Considerations**:
	- Identify business logic
	- Determine resource exposure
	- Ensure future extensibility

### OpenAPI Specification
- **Key concepts**:
	- **Endpoint**: defines functionality
	- **Operation**: API method (`GET`, `POST`, `PUT`, `DELETE`)
	- **Path**: identifies endpoint (e.g., `/users/{user_id}`)
	- **Content**: defines request data types (`JSON`, `HTML`, etc.)
	- **Schema**: data structure for requests and responses
- Response handling
- API tagging
- Consistent style & components

### Summary
- Microservices should follow **resource-oriented** principles (Pragmatic REST)
- APIs should be **stateless**, **structured** and **future-proof**
- OpenAPI specification provides a standardized approach to API documentation
- API design should prioritize **clarity**, **consistency** and **flexibility**