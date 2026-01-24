$(document).ready(function () {
  // Bootstrap Carousel Effect Ken Burns
  function doAnimations(elems) {
    const animEndEv = 'animationend';

    elems.forEach((elem) => {
      elem.classList.add('animate__animated', 'animate__flipInX');
      elem.addEventListener(animEndEv, () => {
        elem.classList.remove('animate__animated', 'animate__flipInX');
      });
    });
  }

  // Variables on page load
  const carouselKenBurns = document.querySelector('#carouselKenBurns');

  if (carouselKenBurns) {
    const firstAnimatingElems = Array.from(
      carouselKenBurns.querySelector('.carousel-item:first-child')
        .querySelectorAll("[data-animation^='animated']")
    );

    doAnimations(firstAnimatingElems);

    carouselKenBurns.addEventListener('slid.bs.carousel', (e) => {
      const animatingElems = Array.from(e.relatedTarget.querySelectorAll("[data-animation^='animated']"));
      doAnimations(animatingElems);
    });
  }

  // Fancy Box
  Fancybox.bind(".slick-slide:not(.slick-cloned) [data-fancybox]", {
    Carousel: {
      Video: {
        autoplay: false,
      },
    },
  });

  Fancybox.bind("[data-fancybox]:not(.slick-slide [data-fancybox])", {
    Carousel: {
      Video: {
        autoplay: false,
      },
    },
  });

  // Testimonial
  $('.testimonial-slide').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    dots: false,
    arrows: false,
    infinite: false,
    autoplaySpeed: 2000,
    responsive: [{
      breakpoint: 1200,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1,
      }
    }]
  });

   // Project Photos
  $('.project-photos').slick({
    slidesToShow: 1,
    slidesToScroll: 1,
    autoplay: true,
    dots: false,
    arrows: false,
    infinite: true,
    autoplaySpeed: 2000,
  });

  // Initialize AOS (Animate On Scroll)
  AOS.init({
    duration: 800,
    once: true,
    anchorPlacement: 'top-center',
  });

  // Client Logo
  $('.client-logos').slick({
    slidesToShow: 5,
    slidesToScroll: 1,
    infinite: true,
    autoplay: true,
    autoplaySpeed: 1500,
    arrows: false,
    dots: false,
    pauseOnHover: false,
    responsive: [{
      breakpoint: 1024,
      settings: {
        slidesToShow: 3
      }
    }, {
      breakpoint: 768,
      settings: {
        slidesToShow: 1
      }
    }]
  });
});