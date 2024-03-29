// Get the objects we need to modify
let updatePersonForm = document.getElementById('update-artist-form-ajax');

// Modify the objects we need
updatePersonForm.addEventListener("submit", function (e) {

    // Prevent the form from submitting
    e.preventDefault();

    // Get form fields we need to get data from
    let inputArtistID = document.getElementById("mySelect");
    let inputName = document.getElementById("input-name-update");
    let inputBio = document.getElementById("input-bio-update")

    // Get the values from the form fields
    let artistIDValue = inputArtistID.value;
    let nameValue = inputName.value;
    let bioValue = inputBio.value;


    // currently the database table for Artists does not allow updating values to NULL
    // so we must abort if being bassed NULL for name

    // Put our data we want to send in a javascript object
    let data = {
        artistID: artistIDValue,
        name: nameValue,
        bio: bioValue
    }

    // Setup our AJAX request
    var xhttp = new XMLHttpRequest();
    xhttp.open("PUT", "/put-artist-ajax", true);
    xhttp.setRequestHeader("Content-type", "application/json");

    // Tell our AJAX request how to resolve
    xhttp.onreadystatechange = () => {
        if (xhttp.readyState == 4 && xhttp.status == 200) {

            // Add the new data to the table
            updateRow(xhttp.response, artistIDValue);

        }
        else if (xhttp.readyState == 4 && xhttp.status != 200) {
            console.log("There was an error with the input.")
        }
    }

    // Send the request and wait for the response
    xhttp.send(JSON.stringify(data));

})


function updateRow(data, artistID) {
    console.log(data)
    let parsedData = JSON.parse(data);
    console.log(parsedData)
    let table = document.getElementById("artists-table");

    for (let i = 0, row; row = table.rows[i]; i++) {
        //iterate through rows
        //rows would be accessed using the "row" variable assigned in the for loop
        if (table.rows[i].getAttribute("data-value") == artistID) {

            // Get the location of the row where we found the matching artist ID
            let updateRowIndex = table.getElementsByTagName("tr")[i];

            // Get td of name value
            let tdname = updateRowIndex.getElementsByTagName("td")[1];
            let tdbio = updateRowIndex.getElementsByTagName("td")[2];

            // Reassign name to our value we updated to
            tdname.innerHTML = parsedData[0].name;
            tdbio.innerHTML = parsedData[0].bio;
        }
    }
}