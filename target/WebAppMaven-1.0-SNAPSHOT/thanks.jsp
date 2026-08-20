<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.example.User" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="utf-8">
            <title>Murach's Java Servlets and JSP</title>
            <link rel="stylesheet" href="styles/main.css" type="text/css">
        </head>

        <body>
            <h1>Thanks for joining our email list</h1>
            <p>
                <% User user=(User) request.getAttribute("user"); %>
                    Thanks <%= user.getFirstName() %>
                        <%= user.getLastName() %> for joining.
                            We'll send email to <%= user.getEmail() %>
            </p>
            <p>
                <a href="index.html">Join again</a>
            </p>
        </body>

        </html>