---
---

for reference in document.querySelectorAll('.js-figure-reference')
  figure = document.querySelector(reference.getAttribute('href'))
  reference.innerHTML = "Figure #{figure.querySelector('.counter').innerHTML}"