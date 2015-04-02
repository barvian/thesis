---
---

for reference in document.querySelectorAll('.c-figure-reference')
  figure = document.querySelector(reference.getAttribute('href'))
  reference.innerHTML = "Figure #{figure.querySelector('.c-counter').innerHTML}"