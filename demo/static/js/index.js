let u_calc = $("#u_calc").attr("data-url");
let u_check = $("#u_check").attr("data-url");

// see https://docs.djangoproject.com/en/dev/ref/csrf/
function getCookie(name) {
    let cookieValue = null;
    if (document.cookie && document.cookie !== '') {
        let cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
            let cookie = cookies[i].trim();
            // Does this cookie string begin with the name we want?
            if (cookie.substring(0, name.length + 1) === (name + '=')) {
                cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                break;
            }
        }
    }
    return cookieValue;
}

let csrf_token = getCookie('csrftoken');

function csrfSafeMethod(method) {
    // these HTTP methods do not require CSRF protection
    return (/^(GET|HEAD|OPTIONS|TRACE)$/.test(method));
}

function listenToTask(task_id) {
    let runningTaskNumber = 1;
    document.getElementById('table').style.visibility = 'visible';
    console.log(task_id);
    let insertRow = function (data) {
        // noinspection JSUnresolvedVariable
        let row =
            "<tr>\
                <td><div class='card-body'>" + data.task_id + "</div></td>\
                <td><div class='card-body'>" + data.eventTime + "</div></td>\
                <td><div class='card-body'>" + data.processingTime + "</div></td>\
                <td><div class='card-body'>" + data.finishTime + "</div></td>\
                <td><div class='card-body'>" + data.result + "</div></td>\
             </tr>";
        $('#table tr:last').after(row);
    };

    let poll = function () {
        $.ajax({
            beforeSend: function (xhr, settings) {
                if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
                    xhr.setRequestHeader("X-CSRFToken", csrf_token);
                }
            },
            method: "GET",
            type: "GET",
            url: u_check + "?task_id=" + task_id,
            async: true,
            dataType: "json",
            contentType: "application/json",
            success: function (data) {
                if (data.status === "SUCCESS") {
                    runningTaskNumber -= 1;
                    insertRow(data);
                } else {
                    console.log(data.status);
                }
            },
        });
    };


    let check = function () {
        let refresh = setInterval(function () {
            if (runningTaskNumber === 0) {
                clearInterval(refresh);
            } else {
                poll();
            }
        }, 1000)
    };

    if (runningTaskNumber > 0) check();
}


function get_result(number) {
    let n = number.val();
    if (n.length === 0) {
        alert("please input a integer before submit.")
    } else if (!n.match(/^\d+$/)) {
        alert(n + " is not a valid integer.");
    } else {
        $.ajax({
            beforeSend: function (xhr, settings) {
                if (!csrfSafeMethod(settings.type) && !this.crossDomain) {
                    xhr.setRequestHeader("X-CSRFToken", csrf_token);
                }
            },
            method: "POST",
            type: "POST",
            url: u_calc,
            async: true,
            dataType: "json",
            data: JSON.stringify({'number': n, 'eventTime': new Date().toUTCString()}),
            contentType: "application/json",
            success: function (data) {
                // noinspection JSUnresolvedVariable
                listenToTask(data.task_id);
            },
        });
    }
}

