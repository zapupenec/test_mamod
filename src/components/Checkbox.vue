<template>
  <label class="label">
    <input
      class="input visually-hidden"
      type="checkbox"
      :checked="checked"
      @change="handleChange"
      :disabled="disabled"
    />
    <span
      :class="{
        checkbox: true,
        invalid: status === 'invalid',
      }"
    />
    <slot />
    <p class="feedback" v-if="status === 'invalid'">{{ feedback }}</p>
  </label>
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
    status: {
      default: 'default', // 'default' | 'invalid'
    },
    feedback: {
      type: String,
      default: '',
    },
    name: {
      type: String,
    },
    disabled: {
      type: Boolean,
    },
  },
  methods: {
    handleChange(e) {
      this.$emit('change', e.target.checked);
      this.$emit('change-status', { [this.name]: 'default' });
    },
  },
};
</script>

<style scoped>
.label {
  max-width: 540px;
  color: var(--grayscale-900);
  font-size: 14px;
  font-weight: 400;
  line-height: 19px;
  letter-spacing: -0.021px;
  user-select: none;
  cursor: pointer;
  position: relative;
  padding-left: 33px;
}

.invalid {
  border: 5px solid salmon;
  border-color: var(--invalid-field);
  box-shadow: 0 0 0 3px var(--invalid-field);
}

.visually-hidden {
  position: absolute;
  width: 1px;
  height: 1px;
  clip: rect(0 0 0 0);
  overflow: hidden;
}

.feedback {
  position: absolute;
  top: calc(100% + 5px);
  color: var(--invalid-field);
  font-size: 14px;
  font-weight: 400;
  line-height: 19px;
  letter-spacing: -0.021px;
}

/* not checked */
.checkbox {
  position: absolute;
  width: 19px;
  height: 17px;
  margin-left: -33px;
  border: 1px solid var(--grayscale-300);
  background-repeat: no-repeat;
  background-position: center center;
  border-radius: 5px;
}

.input:hover + .checkbox,
.input:focus + .checkbox {
  box-shadow: none;
  border-color: var(--blue-1);
}

/* checked */
.input:checked + .checkbox {
  border-color: var(--blue-1);
  background-color: var(--blue-1);
  background-image: url('src/assets/vector.svg');
}

.input:hover:checked + .checkbox,
.input:focus:checked + .checkbox {
  box-shadow: 0 0 0 3px var(--blue-3);
}

/* disabled */
.input:disabled + .checkbox,
.input:disabled:checked + .checkbox {
  border-color: var(--grayscale-300);
  background-color: var(--grayscale-300);
  box-shadow: none;
  cursor: default;
  color: var(--grayscale-600);
}
</style>
