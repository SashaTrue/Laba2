<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cars List</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $(document).ready(function() {
            loadCarsList();
        });

        function loadCarsList() {
            $.getJSON("JSONServlet", function(data) {
                var carsList = $("#cars-list");
                carsList.empty();
                $.each(data, function() {
                    var car = this;
                    if (car.make !== undefined) {
                        carsList.append("<tr>" +
                            "<td>" + car.make + "</td>" +
                            "<td>" + car.model + "</td>" +
                            "<td>" + car.year + "</td>" +
                            "<td>" + car.color + "</td>" +
                            "<td>" + car.price + "</td>" +
                            "</tr>");
                    }
                });
            });
        }

        function addCar() {
            var make = $("#make").val();
            var model = $("#model").val();
            var year = parseInt($("#year").val());
            var color = $("#color").val();
            var price = parseFloat($("#price").val());

            // Create a JSON object with car properties
            var car = {
                "make": make,
                "model": model,
                "year": year,
                "color": color,
                "price": price
            };

            $.ajax({
                url: "JSONServlet",
                type: "POST",
                data: JSON.stringify(car),
                contentType: "application/json",
                success: function(data) {
                    loadCarsList();
                },
                error: function(error) {
                    console.log(error);
                    alert("Error: " + error.statusText);
                }
            });
        }
    </script>
    <style>
        body {
            font-family: Arial, sans-serif;
            font-size: 16px;
        }

        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #4CAF50;
            color: white;
        }

    </style>
</head>
<body>
<h1>Cars List</h1>
<table id="cars-list" border="1">
    <tr>
        <th>Make</th>
        <th>Model</th>
        <th>Year</th>
        <th>Color</th>
        <th>Price</th>
    </tr>
</table>
<h2>Add a Car</h2>
<form id="add-car-form" onsubmit="event.preventDefault(); addCar();">
    <table>
        <tr>
            <td><label for="make">Make:</label></td>
            <td><input type="text" id="make"></td>
        </tr>
        <tr>
            <td><label for="model">Model:</label></td>
            <td><input type="text" id="model"></td>
        </tr>
        <tr>
            <td><label for="year">Year:</label></td>
            <td><input type="number" id="year"></td>
        </tr>
        <tr>
            <td><label for="color">Color:</label></td>
            <td><input type="text" id="color"></td>
        </tr>
        <tr>
            <td><label for="price">Price:</label></td>
            <td><input type="number" id="price" step="0.01"></td>
        </tr>
        <tr>
            <td></td>
            <td><button type="submit">Add</button></td>
        </tr>
    </table>
</form>
</body>
</html>
