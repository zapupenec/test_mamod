<template>
  <div class="input">
    <input
      :class="{
        field: true,
        fieldPassword: type === 'password',
        valid: status === 'valid',
        invalid: status === 'invalid',
      }"
      :type="type === 'password' ? inputTypePassword : type"
      :placeholder="placeholder"
      :value="value"
      @input="handleInput"
      :disabled="disabled"
    />
    <button
      v-if="type === 'password' && value !== ''"
      :class="{ btnHidePassword: true, showenPassword: isShowenPassword }"
      type="button"
      :aria-label="`${isShowenPassword ? 'Скрыть' : 'Показать'} пароль`"
      @click="toggleIsShowenPassword"
      :disabled="disabled"
    />
    <p class="feedback" v-if="status === 'invalid'">{{ feedback }}</p>
  </div>
</template>

<script>
export default {
  props: {
    type: {
      type: String,
      default: 'text',
    },
    placeholder: {
      type: String,
      required: true,
    },
    value: {
      type: String,
      default: '',
    },
    status: {
      default: 'default', // 'default' | 'valid' | 'invalid'
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
  data() {
    return {
      isShowenPassword: false,
      inputTypePassword: 'password',
    };
  },
  methods: {
    toggleIsShowenPassword() {
      this.isShowenPassword = !this.isShowenPassword;
      this.inputTypePassword = this.isShowenPassword ? 'text' : 'password';
    },
    handleInput(e) {
      this.$emit('input', e.target.value);
      this.$emit('change-status', { [this.name]: 'default' });
    },
  },
};
</script>

<style scoped>
.input {
  position: relative;
  width: 100%;
  height: 100%;

  color: var(--grayscale-900);
  font-size: 14px;
  font-weight: 400;
  line-height: 19px;
  letter-spacing: -0.021px;
  width: 100%;
  display: flex;
  align-items: center;
  gap: 10px;
}
.field {
  width: 100%;
  height: 100%;
  border-radius: 11px;
  border: 1px solid var(--grayscale-300);
  padding: 10px;
}

.field:disabled {
  background-color: var(--grayscale-300);
  border-color: var(--grayscale-300);
  color: var(--grayscale-600);
  pointer-events: none;
}

.fieldPassword {
  padding-right: 41px;
}

.field:hover,
.field:focus {
  border-color: var(--blue-1);
}

.field::placeholder {
  color: var(--grayscale-600);
}

.valid {
  border-color: var(--valid-field);
}

.invalid {
  border-color: var(--invalid-field);
}

.btnHidePassword {
  height: 100%;
  width: 21px;
  height: 21px;
  right: 10px;
  position: absolute;
}

.btnHidePassword:hover,
.btnHidePassword:focus {
  border: 1px solid var(--blue-1);
  border-radius: 5px;
}

.btnHidePassword:disabled {
  pointer-events: none;
}

.btnHidePassword::before {
  position: absolute;
  content: '';
  width: 100%;
  height: 100%;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  background-image: url('src/assets/showed.svg');
  background-repeat: no-repeat;
  background-position: center center;
}

.showenPassword::before {
  background-image: url('src/assets/hided.svg');
}

.feedback {
  position: absolute;
  top: calc(100% + 5px);
  color: var(--invalid-field);
  font-size: 14px;
  font-weight: 400;
  line-height: 19px;
  letter-spacing: -0.021px;
  padding-left: 10px;
}
</style>
