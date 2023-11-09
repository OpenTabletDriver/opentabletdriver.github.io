function injectMarkdownClasses() {
    // Select the parent element with class markdown-content
    var parentElement = document.querySelector('.markdown-content');
    if (parentElement === null)
        return;

    // From the selected parent, select all direct child blockquote elements
    var blockquoteElements = parentElement.querySelectorAll('blockquote');
    if (blockquoteElements === null)
        return;

    // Loop through each blockquote element and add the desired classes
    blockquoteElements.forEach(function (blockquoteElement) {
        blockquoteElement.classList.add('small');
        blockquoteElement.classList.add('text-muted');
    });
}

injectMarkdownClasses();