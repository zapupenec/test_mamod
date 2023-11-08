<template>
  <div id="app">
    <AuthForm />
  </div>
</template>

<script>
import AuthForm from './components/AuthForm.vue';
export default {
  components: {
    AuthForm,
  },
};
</script>

<style>
#app {
  height: 100vh;
  width: 100vw;
  font-family: Montserrat, sans-serif;
  font-style: normal;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: var(--bg-main);
}
</style>
