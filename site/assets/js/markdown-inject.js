function injectMarkdownClasses() {
  let parentElement = document.querySelector('.markdown-content');
  if (parentElement === null)
    return;

  let injectMarkdownClassConditional = (selector, condition, classes) => {
    parentElement.querySelectorAll(selector)?.forEach((element) => {
      if (condition(element)) {
        classes.forEach((classToAdd) => {
          element.classList.add(classToAdd);
        });
      }
    });
  }

  let injectMarkdownClass = (selector, classes) => {
    injectMarkdownClassConditional(selector, (element) => true, classes);
  }

  let alertTypes = [
    'alert-success',
    'alert-info',
    'alert-warning',
    'alert-danger',
    'alert-primary',
    'alert-secondary',
    'alert-light',
    'alert-dark'
  ];

  injectMarkdownClass('blockquote', ['alert']);
  injectMarkdownClassConditional('blockquote', hasNoClass(alertTypes), ['alert-secondary']);
  injectMarkdownClass('& > * blockquote', ['alert-compact', 'small']); // blockquotes that are not an immediate children
  injectMarkdownClass('blockquote a', ['alert-link']);
  injectMarkdownClass('table', ['table']);
}

function hasNoClass(classes) {
  return (element) => {
    for (classToFind of classes) {
      if (element.classList.contains(classToFind)) {
        return false
      }
    }

    return true;
  }
}

injectMarkdownClasses();
