<template>
  <div class="home">
    <img alt="Vue logo" src="../assets/logo.png">
    <Meteo msg="Méteo de Montpellier" date="Mercredi 27 octobre"/>
  </div>
</template>

<script>
// @ is an alias to /src
import Meteo from '@/components/Meteo.vue'

export default {
  name: 'Home',
  components: {
    Meteo
  }
}
</script>
