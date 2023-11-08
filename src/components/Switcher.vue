<template>
  <div class="wrapper">
    <label class="label">
      <input
        class="input visually-hidden"
        type="checkbox"
        :checked="checked"
        v-on:change="handleChange"
        :disabled="disabled"
      />
      <span class="switcher" />
      <slot />
    </label>
    <p class="hint">{{ hint }}</p>
  </div>
</template>

<script>
export default {
  model: {
    prop: 'checked',
    event: 'change',
  },
  props: {
    checked: {
      type: Boolean,
      default: false,
    },
    hint: {
      type: String,
    },
    disabled: {
      type: Boolean,
    },
  },
  methods: {
    handleChange(e) {
      this.$emit('change', e.target.checked);
    },
  },
};
</script>

<style scoped>
.wrapper {
  --height: 20px;
  --width: 40px;
  --border-size: 0.5px;
  --gap: 4px;
}

.label {
  color: var(--grayscale-900);
  font-size: 16px;
  font-weight: 500;
  line-height: 19px;
  user-select: none;
  display: block;
  cursor: pointer;
  position: relative;
  padding-left: calc(var(--width) + var(--gap));
}

.visually-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  clip: rect(0 0 0 0);
  overflow: hidden;
}

.hint {
  margin-top: 10px;
  color: var(--grayscale-700);
  font-size: 14px;
  font-weight: 400;
  line-height: 19px;
  letter-spacing: -0.021px;
  padding-left: calc(var(--width) + var(--gap));
}

/* not checked */
.switcher {
  position: absolute;
  width: var(--width);
  height: var(--height);
  margin-left: calc(0px - var(--width) - var(--gap));
  border: var(--border-size) solid var(--alpha-blue-15);
  border-radius: calc(var(--height) / 2);
  background-color: var(--grayscale-300);
  transition: background-color 0.5s ease;
}

.switcher::after {
  content: '';
  position: absolute;
  top: calc(0px - var(--border-size) * 1.5);
  left: calc(0px - var(--border-size) * 1.5);
  width: calc(var(--height) + var(--border-size));
  height: calc(var(--height) + var(--border-size));
  border: var(--border-size) solid var(--grayscale-400);
  border-radius: 50%;
  background-color: var(--grayscale-50);
  transition: left 0.5s ease;
}

.input:hover + .switcher,
.input:focus + .switcher {
  box-shadow: 0 0 0 3px var(--blue-3);
}

/* checked */
.input:checked + .switcher {
  background-color: var(--blue-1);
}

.input:checked + .switcher::after {
  left: calc(var(--width) - var(--height) - var(--border-size));
}

/* disabled */
.input:disabled + .switcher,
.input:disabled + .switcher::after,
.input:checked:disabled + .switcher,
.input:checked:disabled + .switcher::after {
  background-color: var(--grayscale-300);
  box-shadow: none;
}
</style>
