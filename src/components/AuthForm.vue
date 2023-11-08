<template>
  <form class="form" @submit.prevent="handleSubmit" novalidate v-if="submitStatus !== 'success'">
    <h2 class="title">Регистрация</h2>
    <div class="body">
      <p class="text">Заполните Ваши данные</p>
      <Input
        class="cell1"
        type="text"
        placeholder="Имя"
        feedback="Ввведите имя"
        v-model.trim="formData.username"
        :status="fieldStatuses.username"
        name="username"
        @change-status="changeStatus"
        :disabled="submitStatus === 'loading'"
      />
      <Input
        class="cell2"
        type="email"
        placeholder="Email"
        feedback="Введите валидный email"
        v-model.trim="formData.email"
        :status="fieldStatuses.email"
        name="email"
        @change-status="changeStatus"
        :disabled="submitStatus === 'loading'"
      />
      <Selector
        class="cell4"
        placeholder="Должность"
        feedback="Выберите должность"
        :options="roles"
        v-model="formData.role"
        :status="fieldStatuses.role"
        name="role"
        @change-status="changeStatus"
        :disabled="submitStatus === 'loading'"
      />
      <Input
        class="cell5"
        type="password"
        placeholder="Пароль"
        feedback="Введите пароль"
        v-model="formData.password"
        :status="fieldStatuses.password"
        name="password"
        @change-status="changeStatus"
        :disabled="submitStatus === 'loading'"
      />
      <Input
        class="cell6"
        type="password"
        placeholder="Повторите пароль"
        feedback="Пароли не совпадают"
        v-model="formData.password_repeat"
        :status="fieldStatuses.password_repeat"
        name="password_repeat"
        @change-status="changeStatus"
        :disabled="submitStatus === 'loading'"
      />
    </div>
    <div class="footer">
      <div class="checkboxes">
        <Switcher
          hint="Включает профиль для просмотра другими пользователями по ссылке"
          v-model="formData.public"
          :disabled="submitStatus === 'loading'"
        >
          Хотите чтобы Ваш профиль видели другие участники платформы?
        </Switcher>
        <Checkbox
          v-model="isAgreeRules"
          :status="fieldStatuses.agreeRules"
          feedback="Для регистрации необходимо Ваше согласие"
          name="agreeRules"
          @change-status="changeStatus"
          :disabled="submitStatus === 'loading'"
        >
          <template>
            Регистрируясь, Вы соглашаетесь с
            <a class="link" href="#" target="_blank">политикой конфиденциальности</a> и обработкой
            <a class="link" href="#" target="_blank">персональных данных</a>
          </template>
        </Checkbox>
      </div>
      <Button class="button" type="submit" :disabled="submitStatus === 'loading'">
        <template> Зарегистрироваться </template>
      </Button>
    </div>
  </form>
  <div class="success" v-else>Регистрация успешно завершена</div>
</template>

<script>
import Button from 'src/components/Button.vue';
import Checkbox from 'src/components/Checkbox.vue';
import Input from 'src/components/Input.vue';
import Selector from 'src/components/Selector.vue';
import Switcher from 'src/components/Switcher.vue';

export default {
  components: {
    Button,
    Checkbox,
    Input,
    Selector,
    Switcher,
  },
  data() {
    return {
      roles: [
        { value: 1, name: 'Конструктор' },
        { value: 2, name: 'Разработчик' },
        { value: 3, name: 'Лётчик' },
        { value: 4, name: 'Дизайнер' },
      ],
      submitStatus: 'idle', // 'idle' | 'loading' | 'success' |'error'
      fieldStatuses: {
        username: 'default', // 'default' | 'valid' | 'invalid'
        email: 'default', // 'default' | 'valid' | 'invalid'
        role: 'default', // 'default' | 'valid' | 'invalid'
        password: 'default', // 'default' | 'valid' | 'invalid'
        password_repeat: 'default', // 'default' | 'valid' | 'invalid'
        agreeRules: 'default', // 'default' | 'invalid'
      },
      formData: {
        username: '',
        email: '',
        role: null,
        password: '',
        password_repeat: '',
        public: false,
      },
      isAgreeRules: true,
    };
  },
  methods: {
    async handleSubmit() {
      if (this.isValidData()) {
        this.submitStatus = 'loading';
        console.log(this.formData);
        try {
          // просто возвращает статус 201 и JSON: {"id":1}
          const response = await fetch(
            'https://d53852bd-6568-4f50-a261-95a6764f4974.mock.pstmn.io/api/auth',
            {
              method: 'POST',
              headers: {
                'Content-Type': 'application/json',
              },
              body: JSON.stringify(this.formData),
            },
          );
          const data = await response.json();
          // тут ещё нужна обработка ответа сервера, если допустим пользователь уже существует
          this.submitStatus = 'success';
        } catch (error) {
          console.error(error);
          this.submitStatus = 'error';
          // некая обработка сетевой ошибки
        }
      }
    },
    isValidData() {
      const { fieldStatuses, formData, isAgreeRules } = this;

      const isValidUsername = formData.username !== '' && /^\S*$/g.test(formData.username);
      fieldStatuses.username = isValidUsername ? 'valid' : 'invalid';

      const isValidEmail = /^((?!\.)[\w-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$/g.test(
        formData.email.toLowerCase(),
      );
      fieldStatuses.email = isValidEmail ? 'valid' : 'invalid';

      const isValidPassword = formData.password !== '' && /^\S*$/g.test(formData.username);
      fieldStatuses.password = isValidPassword ? 'valid' : 'invalid';

      const isValidConfirmPassword =
        formData.password_repeat !== '' && formData.password === formData.password_repeat;
      fieldStatuses.password_repeat = isValidConfirmPassword ? 'valid' : 'invalid';

      const isValidRole = !!formData.role;
      fieldStatuses.role = isValidRole ? 'valid' : 'invalid';

      fieldStatuses.agreeRules = isAgreeRules ? 'default' : 'invalid';
      return (
        isValidUsername &&
        isValidEmail &&
        isValidPassword &&
        isValidConfirmPassword &&
        isValidRole &&
        isAgreeRules
      );
    },
    changeStatus(response) {
      this.fieldStatuses = { ...this.fieldStatuses, ...response };
    },
  },
};
</script>

<style scoped>
.form {
  width: 960px;
  height: 547px;
  margin: 0 auto;
  background-color: var(--bg-form);
  border-radius: 15px;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
}

.title {
  color: var(--grayscale-900);
  font-size: 19px;
  font-weight: 700;
  line-height: 27px;
  letter-spacing: -0.066px;
  padding: 17px 15px 17px 31px;
}

.body {
  position: relative;
  border-top: 2px solid var(--gray-2);
  border-bottom: 2px solid var(--gray-2);
  padding: 70px 15px 30px 31px;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  grid-template-rows: repeat(3, 39px);
  grid-template-areas:
    'c1 c2'
    '. c4'
    'c5 c6';
  gap: 31px 14px;
}

.text {
  font-size: 16px;
  font-weight: 500;
  line-height: 19px;
  position: absolute;
  top: 17px;
  left: 31px;
}

.cell1 {
  grid-area: c1;
}

.cell2 {
  grid-area: c2;
}

.cell4 {
  grid-area: c4;
}

.cell5 {
  grid-area: c5;
}

.cell6 {
  grid-area: c6;
}

.footer {
  max-width: 100%;
  padding: 23px 15px 65px 31px;
  display: flex;
}

.checkboxes {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.link {
  color: var(--blue-1);
}

.link:focus,
.link:hover {
  text-decoration: underline;
  text-decoration-color: var(--blue-1);
}

.button {
  align-self: flex-end;
  min-width: 302px;
  height: 40px;
}

.success {
  width: 500px;
  height: 200px;
  margin: 0 auto;
  background-color: var(--bg-form);
  border-radius: 15px;
  display: flex;
  justify-content: center;
  align-items: center;

  color: var(--grayscale-900);
  font-size: 19px;
  font-weight: 700;
  line-height: 27px;
  letter-spacing: -0.066px;
  padding: 17px 15px 17px 31px;
}
</style>
