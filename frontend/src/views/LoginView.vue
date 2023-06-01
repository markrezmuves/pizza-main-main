<template>
  <div class="login-panel p-4">
    <div class="mb-4">
      <h2 class="text-2xl font-bold text-gray-800">Sign In</h2>
    </div>
    <div class="mb-3">
      <label for="userName" class="sr-only">User name:</label>
      <input
        type="text"
        class="login-input"
        id="userName"
        placeholder="User name"
        v-model="storeLogin.userName"
      />
    </div>
    <div class="mb-3">
      <label for="password" class="sr-only">Password:</label>
      <input
        type="password"
        class="login-input"
        id="password"
        placeholder="Password"
        v-model="storeLogin.password"
      />
    </div>
    <button type="button" class="login-button" @click="login()">
      Sign In
    </button>
    <div v-if="loginErrorMessage" class="login-error-message">
  {{ loginErrorMessage }}
</div>
</div>

</template>

<script>
import { useUrlStore } from "@/stores/url";
const storeUrl = useUrlStore();
import { useLoginStore } from "@/stores/login";
import router from "../router";
const storeLogin = useLoginStore();
export default {
  data() {
    return {
      storeUrl,
      storeLogin,
      loginErrorMessage: null,
    };
  },
  methods: {
    loginErrorMessageShow(message) {
      this.loginErrorMessage = message;
      setTimeout(() => {
        this.loginErrorMessage = null;
      }, 3000);
    },
    async login() {
      const url = this.storeUrl.urlLogin;
      const user = {
        userName: this.storeLogin.userName,
        password: this.storeLogin.password,
      };
      const config = {
        method: "POST",
        headers: {
          Accept: "application/json",
          "Content-Type": "application/json",
        },
        body: JSON.stringify(user),
      };
      try {
        // this.errorMessage = null;
        const response = await fetch(url, config);
        if (!response.ok) {
          this.loginErrorMessageShow("Server error 1");
          return;
        }
        const data = await response.json();
        if (data.success) {
          //sikeres bejelentkezés
          this.storeLogin.loginSuccess = data.success;
          this.storeLogin.accessToken = data.data.accessToken;
          this.storeLogin.refreshToken = data.data.refreshToken;
          this.storeLogin.userId = data.data.userId;
          this.storeLogin.number = data.data.number;
          this.storeLogin.loginSuccess = data.success;
          this.storeLogin.accessTime = parseInt(data.data.accessTime);
          router.push("/");
          // this.timer();
          // this.getTodos();
        } else {
          //sikertelen bejelenkezés
          this.loginErrorMessageShow("Hibás usernév vagy jelszó");
        }
      } catch (error) {
        // this.errorMessage = `Server error`;
        this.loginErrorMessageShow("Server error 2");
      }
    },
  },
};
</script>

<style>
.login-panel {
  max-width: 400px;
  margin: 0 auto;
  background-color: whitesmoke;
  border-radius: 120px;
  box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1),
    0 4px 6px -2px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 2rem;
}

.login-input {
  border: none;
  border-radius: 8px;
  padding: 1rem;
  font-size: 1.4rem;
  background-color: #f2f2f2;
  margin-bottom: 1.5rem;
  width: 100%;
}

.login-button {
  background-color: gray;
  color: black;
  border: none;
  border-radius: 8px;
  padding: 1rem 2rem;
  font-size: 1.2rem;
  cursor: pointer;
  transition: background-color 0.5s ease-in-out;
}

.login-button:hover {
  background-color: white;
}

.login-error-message {
  color: #f44336;
  margin-top: 1rem;
  font-size: 1.1rem;
  text-align: center;
}
</style>