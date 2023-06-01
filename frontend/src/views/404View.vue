<template>
  <div class="error-container">
    <h1 class="error-title">Oops!</h1>
    <p class="error-message">A keresett oldal nem található</p>
  </div>
</template>
<script setup>
</script>
<style>
  .error-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    height: 100vh;
  }
  
  .error-title {
    font-size: 8rem;
    font-weight: bold;
    margin-bottom: 0;
    color: #F94144;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
  }
  
  .error-message {
    font-size: 2rem;
    margin-top: 0;
    color: #F8961E;
    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
  }
</style>