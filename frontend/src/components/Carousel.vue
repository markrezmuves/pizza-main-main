<template>
  <div class="carousel slide" id="carouselExample" data-bs-ride="carousel">
    <div class="carousel-inner">
      <div class="carousel-item active">
        <img src="https://cdn.pixabay.com/photo/2017/12/09/08/18/pizza-3007395__480.jpg" class="d-block w-100" alt="..." />
      </div>
      <div class="carousel-item">
        <img src="https://www.mokuslekvar.hu/wp-content/uploads/2022/04/pizza-9.jpg" class="d-block w-100" alt="..." />
      </div>
      <div class="carousel-item">
        <img src="https://images8.alphacoders.com/644/thumb-1920-644361.jpg" class="d-block w-100" alt="..." />
      </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#carouselExample" data-bs-slide="prev">
      <span class="carousel-control-prev-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Previous</span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#carouselExample" data-bs-slide="next">
      <span class="carousel-control-next-icon" aria-hidden="true"></span>
      <span class="visually-hidden">Next</span>
    </button>
    <div class="carousel-caption">
      <h1 class="fw-bold mb-4 text-uppercase">Pizzéria</h1>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style>
.carousel-item img {
  height: 400px;
  object-fit: cover;
}

.carousel-caption {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 85%;
  z-index: 1;
}

.carousel-caption h1 {
  background-color: rgba(255, 255, 255, 0.6);
  border-radius: 10px;
  padding: 20px;
  font-size: 5rem;
  color: #212529;
}

.carousel-control-prev,
.carousel-control-next {
  width: 5%;
  opacity: 0.5;
}

.carousel-control-prev:hover,
.carousel-control-next:hover {
  opacity: 1;
}
</style>
