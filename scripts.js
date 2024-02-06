// script.js

//By Zackary Paulson with the Help of w3 schools and chat

//submitForm() sends form data to the server, showing an alert. queryTrips() fetches trip info for a driver and logs it to the console.
function submitForm() {
    const formData = new FormData(document.getElementById('tripForm'));

    // Use fetch to send data to the server
    fetch('submit.php', {
        method: 'POST',
        body: formData
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            alert(data.message);
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
}

function queryTrips() {
    const driverQuery = document.getElementById('driverQuery').value;

    // Use fetch to send the query to the server
    fetch(`query.php?driver=${driverQuery}`)
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            // Handle the response data for trip queries
            // You can update the UI or perform other actions based on the data
            console.log(data);
        })
        .catch(error => {
            console.error('There was a problem with the fetch operation:', error);
        });
}
