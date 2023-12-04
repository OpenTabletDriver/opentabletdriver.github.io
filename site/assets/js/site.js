function initializeTooltips() {
  let tooltipElements = document.querySelectorAll('[data-bs-toggle="tooltip"');
  tooltipElements.forEach((tooltipElement) => {
    new bootstrap.Tooltip(tooltipElement);
  })
}

initializeTooltips();
