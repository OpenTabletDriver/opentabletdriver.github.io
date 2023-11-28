document.addEventListener('DOMContentLoaded', function(event) {
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
});
