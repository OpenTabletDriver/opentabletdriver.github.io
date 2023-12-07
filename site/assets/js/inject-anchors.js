document.addEventListener('DOMContentLoaded', (event) => {
  injectAnchorLinks();
  highlightHeader();
});

window.addEventListener('hashchange', (event) => {
  highlightHeader();
});

function getAnchor() {
  let urlParts = document.URL.split('#');
  return urlParts.length > 1 ? urlParts[1] : null;
}

function highlightHeader() {
  let duration = 0.25; // animation duration in seconds
  let iterations = 4; // number of times animation is run

  let anchor = getAnchor();
  if (anchor !== null) {
    let element = document.querySelector('#' + anchor + ' > span');
    if (element !== null) {
      element.style.animation = 'anchor-blink ' + duration + 's ease-in-out 0s ' +
        iterations + ' alternate';

      // unset after animation has run to allow multiple animations per page visit
      setTimeout(function() {
        element.style.animation = '';
      }, duration * iterations * 1000);
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
    // add anchor links
    anchors.add(target);

    // rewrite header's child nodes to wrap the textContent inside a span block.
    // this is to run the animation on the text without the header's padding
    document.querySelectorAll(target).forEach((target) => {
      let headerAnchor = target.querySelector("a.anchorjs-link");
      let span = document.createElement('span');
      span.textContent = target.textContent;
      span.style.display = 'block';

      removeAllChildNodes(target);

      target.appendChild(headerAnchor);
      target.appendChild(span);
    });
  });
}

function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}
