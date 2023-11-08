<template>
  <button class="button" :type="type"><slot /></button>
</template>

<script>
export default {
  props: {
    type: {
      type: String,
      default: 'button',
    },
  },
};
</script>

<style scoped>
.button {
  border-radius: 8px;
  background-color: var(--blue-3);
  color: var(--blue-2);
  font-size: 12px;
  font-weight: 400;
  line-height: 19px;
  letter-spacing: -0.018px;
  user-select: none;
}

.button:hover,
.button:focus {
  border: 1px solid var(--blue-1);
}

.button:disabled {
  background-color: var(--grayscale-300);
  color: var(--grayscale-600);
  pointer-events: none;
}
</style>
