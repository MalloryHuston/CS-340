function deleteEmployeeFromConcert(concertID, employeeID) {
    let link = '/delete-employee-from-concert-ajax/';
    let data = {
        concertID: concertID,
        employeeID: employeeID
    };

    $.ajax({
        url: link,
        type: 'DELETE',
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            deleteRow(concertID, employeeID);
        }
    });
}

function deleteRow(concertID, employeeID) {
    let table = document.getElementById("concerts-table");
    for (let i = 0, row; row = table.rows[i]; i++) {
        if (table.rows[i].getAttribute("concertid-value") == concertID && table.rows[i].getAttribute("employeeid-value") == employeeID) {
            table.deleteRow(i);
            break;
        }
    }
}