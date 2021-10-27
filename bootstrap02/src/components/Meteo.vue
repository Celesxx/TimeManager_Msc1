<template>
  <div class="weather">
    <h1>{{ msg }}</h1>
    <div class="weather-text">
      <p>La température est actuellement de 15°</p>
      <p>Date : {{ date }}</p>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Meteo',
  props: {
    msg: String,
    date: String
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
