function ajaxPost(url, data, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            callback(xhr);
        }
    };
    xhr.open('POST', url);
    xhr.send(data);
}

function ajaxGet(url, data, callback) {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4) {
            callback(xhr);
        }
    };
    xhr.open('GET', url);
    xhr.send(data);
}
