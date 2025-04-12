document.addEventListener('DOMContentLoaded', (event) => {
  injectAnchorLinks();

  // blink on load when an anchor exists in URL
  highlightHeader(getAnchor(document.URL));
});

let __animatingElement = null;

function highlightHeader(anchor) {
  let duration = 0.25; // animation duration in seconds
  let iterations = 4; // number of times animation is run

  if (anchor === null) {
    return;
  }

  let element = document.querySelector('#' + anchor + ' > span');
  if (element !== null && element.style.animation === '') {
    // stop animating previous element
    if (__animatingElement !== null && __animatingElement !== element) {
      __animatingElement.style.animation = null;
    }
    __animatingElement = element;

    element.style.animation = 'anchor-blink ' + duration + 's ease-in-out 0s ' +
      iterations + ' alternate';

    // unset after animation has run to allow multiple animations per page visit
    setTimeout(function() {
      element.style.animation = '';
    }, duration * iterations * 1000);
  }
}

function injectAnchorLinks() {
  let targets = [
    '.markdown-content h2',
    '.markdown-content h3',
    '.markdown-content h4',
    '.markdown-content h5',
    '.markdown-content h6',
  ]

  anchors.options = {
    placement: 'left'
  };

  // add anchor links for each headers
  targets.forEach((target) => {
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

  // blink on click on toc
  let toc = document.getElementById('toc');
  toc?.querySelectorAll('li > a').forEach((tocEntry) => {
    tocEntry.addEventListener('click', (event) => {
      let anchor = getAnchor(tocEntry.getAttribute('href'));
      highlightHeader(anchor);
    });
  });
}

function getAnchor(input) {
  let parts = input.split('#');
  return parts.length > 1 ? parts[1] : null;
}

function removeAllChildNodes(parent) {
    while (parent.firstChild) {
        parent.removeChild(parent.firstChild);
    }
}
