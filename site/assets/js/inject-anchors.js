document.addEventListener('DOMContentLoaded', injectHandler);
window.addEventListener('hashchange', injectHandler);

let __InjectedAnchors = false;

function injectHandler(event) {
  highlightHeader();
  injectAnchorLinks();
}

function getAnchor() {
  let urlParts = document.URL.split('#');
  return urlParts.length > 1 ? urlParts[1] : null;
}

function highlightHeader() {
  let duration = 0.25; // animation duration in seconds
  let iterations = 4; // number of times animation is run

  let anchor = getAnchor();
  if (anchor !== null) {
    let element = document.getElementById(anchor);
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
  if (__InjectedAnchors)
    return;

  __InjectedAnchors = true;

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
