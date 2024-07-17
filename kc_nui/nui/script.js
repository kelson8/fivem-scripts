// Using NUI: https://www.youtube.com/watch?v=Z2yUTkE94pQ
// https://www.geeksforgeeks.org/how-to-select-element-by-id-in-jquery/
// https://stackoverflow.com/questions/6411696/how-to-change-a-text-with-jquery

$(function() {
    window.onload = (e) => {
        window.addEventListener("message", (event) => {
            var item = event.data;
            // if(item !== undefined && item.type === "ui") {
                if(item !== undefined && item.type === "position") {
                if (item.display === true) {
                    $("#pos-x-output").text(Math.round(item.x));
                    $("#pos-y-output").text(Math.round(item.y));
                    $("#pos-z-output").text(Math.round(item.z));
                    $("#heading-output").text(Math.round(item.heading));

                    $('.position').show();
                } else {
                    $('.position').hide();
                }
            }

            // if(item.type === "ping"){
            //     axios.post(`https://${GetParentResourceName()}/pong`, {
            //         foo: "bar",
            //     }).then((response) => {
            //         console.log(JSON.stringify(response.data))
            //     });
            // }
        });
    };
});

//'click', 
$("#destination-cancel").click(() => {
    axios.post(`https://${GetParentResourceName()/releaseFocus}`, {});
});

// Idk if this'll work
$("#destination-submit").click(() => {
    axios.post(`https://${GetParentResourceName()/teleport}`, {
        x: $("#destination-x").value,
        y: $("#destination-y").value,
        z: $("#destination-z").value,
    });
});

document.getElementById('destination-cancel').addEventListener('click', () => {
        axios.post(`https://${GetParentResourceName()/releaseFocus}`, {});
    });

document.getElementById('destination-submit').addEventListener('click', () => {
        axios.post(`https://${GetParentResourceName()/teleport}`, {
            x: document.getElementById('destination-x').value,
            y: document.getElementById('destination-y').value,
            z: document.getElementById('destination-z').value,

        });
    });

window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.type === "position"){
        document.getElementById('heading-output').textContent = data.heading;
        document.getElementById('pos-x-output').textContent = data.x;
        document.getElementById('pos-y-output').textContent = data.y;
        document.getElementById('pos-z-output').textContent = data.z;
    }
});