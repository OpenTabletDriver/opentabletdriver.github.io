document.addEventListener('DOMContentLoaded', function(event) {
  // highlight header first before injecting anchor links to prevent the anchor
  // links from being destroyed by the highlight function
  highlightHeader();
  injectAnchorLinks();
});

function getAnchor() {
  let urlParts = document.URL.split('#');
  return urlParts.length > 1 ? urlParts[1] : null;
}

function highlightHeader() {
  let anchor = getAnchor();
  if (anchor !== null) {
    let element = document.getElementById(anchor);
    if (element !== null) {
      let span = document.createElement('span');
      span.textContent = element.textContent;
      span.style.animation = 'anchor-blink 0.25s ease-in-out 0s 4 alternate'
      element.textContent = '';
      element.appendChild(span);
    }
  }
}

function injectAnchorLinks() {
  let targets = [
    '.markdown-content h2',
    '.markdown-content h3',
    '.markdown-content h4',
    '.markdown-content h5',
  ]

  anchors.options = {
    placement: 'left'
  };

  targets.forEach((target) => {
    anchors.add(target);
  });
}
