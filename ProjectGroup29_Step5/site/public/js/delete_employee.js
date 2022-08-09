function deleteEmployee(employeeID) {
    let link = '/delete-employee-ajax/';
    let data = {
        employeeID: employeeID
    };

    $.ajax({
        url: link,
        type: 'DELETE',
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            deleteRow(employeeID);
        }
    });
}

function deleteRow(employeeID) {
    let table = document.getElementById("employees-table");
    for (let i = 0, row; row = table.rows[i]; i++) {
        if (table.rows[i].getAttribute("data-value") == employeeID) {
            table.deleteRow(i);
            break;
        }
    }
}