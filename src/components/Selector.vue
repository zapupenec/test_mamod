<template>
  <div
    :class="{
      selector: true,
      open: isOpen,
      valid: status === 'valid',
      invalid: status === 'invalid',
      disabled: disabled,
    }"
    role="select"
    :tabIndex="disabled ? -1 : 0"
    v-on:click="toggleIsOpen"
    v-on:keydown.enter="toggleIsOpen"
    :aria-label="`Выбрать ${placeholder}`"
    :aria-disabled="disabled"
  >
    <div :class="{ placeholder: !!value }">
      {{ currentPlaceholder }}
    </div>
    <ul class="optionList" v-if="isOpen" ref="select">
      <li
        class="optionItem"
        role="option"
        tabIndex="0"
        v-for="option of options"
        :key="option.value"
        :aria-selected="value === option"
        v-on:click="selectOption(option)"
        v-on:keydown.enter="selectOption(option)"
        v-on:focusout="handleFocusOut"
      >
        {{ option.name }}
      </li>
    </ul>
    <p class="feedback" v-if="status === 'invalid'">{{ feedback }}</p>
  </div>
</template>

<script>
export default {
  model: {
    prop: 'value',
    event: 'select',
  },
  props: {
    placeholder: {
      type: String,
    },
    options: {
      type: Array,
      default: [],
    },
    value: {
      default: null,
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
      isOpen: false,
      currentPlaceholder: this.placeholder,
    };
  },

  methods: {
    toggleIsOpen() {
      this.isOpen = !this.isOpen;
    },
    selectOption(option) {
      this.$emit('select', option.value);
      this.currentPlaceholder = option.name;
      this.$emit('change-status', { [this.name]: 'default' });
    },
    handleFocusOut(e) {
      if (!this.$refs.select.contains(e.relatedTarget)) {
        this.isOpen = false;
      }
    },
    handleClickPast(e) {
      if (!this.$el.contains(e.target)) {
        this.isOpen = false;
      }
    },
  },
  mounted() {
    window.addEventListener('click', this.handleClickPast);
  },
  destroyed() {
    window.addEventListener('click', this.handleClickPast);
  },
};
</script>

<style scoped>
.selector {
  min-height: 100%;
  border-radius: 11px;
  border: 1px solid var(--grayscale-300);
  color: var(--grayscale-600);
  font-size: 14px;
  font-weight: 400;
  line-height: 19px;
  letter-spacing: -0.021px;
  padding: 10px;
  position: relative;
  cursor: pointer;
  user-select: none;
}

.valid {
  border-color: var(--valid-field);
}

.invalid {
  border-color: var(--invalid-field);
}

.selector::before {
  content: '';
  display: inline-block;
  width: 7px;
  height: 5px;
  background-image: url('src/assets/carret.svg');
  position: absolute;
  top: 13px;
  right: 10px;
  background-repeat: no-repeat;
  background-position: center center;
}

.open::before {
  transform: scale(1, -1);
}

.selector:hover,
.selector:focus {
  border-color: var(--blue-1);
}

.placeholder {
  color: var(--grayscale-900);
}

.arrow {
  display: flex;
  justify-content: center;
  align-items: center;
}

.optionList {
  width: 100%;
  height: calc(300% + 30px);
  padding: 11px 0;
  background-color: var(--bg-form);
  border: 1px solid var(--grayscale-300);
  border-radius: 11px;
  color: var(--grayscale-900);

  position: absolute;
  z-index: 1;
  top: calc(100% + 2px);
  left: 0;

  display: flex;
  flex-direction: column;
  overflow: auto;
}

.optionItem {
  padding: 0 10px;
  display: flex;
  align-items: center;
  width: 100%;
  min-height: 39px;
}

.optionItem:hover,
.optionItem:focus {
  background-color: var(--grayscale-300);
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

.disabled {
  background-color: var(--grayscale-300);
  border-color: var(--grayscale-300);
  color: var(--grayscale-600);
  pointer-events: none;
}
</style>
