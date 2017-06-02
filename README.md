## Dependencies
This application was created using ruby 2.3 and rails 5.1.

## Running
Run the rails server in development mode using `bin/rails server`, then open `http://localhost:3000` in your browser.

## Rendering JSON
By default, todos are rendered as HTML. To get JSON, either add `application/json` to the `Accept` header for the request or set the `json=true` query parameter. This will work for requests to the todo list (`/users/:user_id/todos?json=true`) or todo detail (`/users/:user_id/todos/:id?json=true`). You will need a valid session cookie to make any requests for todos.

If logged into the app in the browser just append the query parameter to the url, or from the command line:
```
curl --cookie "_todo_rails_session=xxxx" --header "Accept:application/json" http://localhost:3000/users/10/todos
```
