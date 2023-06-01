import { createRouter, createWebHistory } from "vue-router";


const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: "/",
      name: "home",
      component: () => import("../views/HomeView.vue"),
      meta: {
        requiresAuth: false,
        title: "Home / Pizza",
      },
    },
    {
      path: "/about",
      name: "about",
      // route level code-splitting
      // this generates a separate chunk (About.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import("../views/AboutView.vue"),
      meta: {
        requiresAuth: false,
        title: "About / Taxi",
      },
    },
    {
      path: "/megrendelok",
      name: "megrendelok",
      component: () => import("../views/Megrendelok.vue"),
      meta: {
        requiresAuth: true,
        title: "Megrendelok / Pizza",
      },
    },
    {
      path: "/PizzakKezeles",
      name: "PizzakKezeles",
      component: () => import("../views/PizzakKezeles.vue"),
      meta: {
        requiresAuth: true,
        title: "Pizzak kezelés / Pizza",
      },
    },
    {
      path: "/UjPizza",
      name: "UjPizza",
      component: () => import("../views/UjPizza.vue"),
      meta: {
        requiresAuth: true,
        title: "Fuvar bevitel / Taxi",
      },
    },
    {
      path: "/count1",
      name: "count1",
      component: () => import("../views/Count1View.vue"),
      meta: {
        requiresAuth: false,
        title: "Counter 1 / Taxi",
      },
    },
    {
      path: "/count2",
      name: "count2",
      component: () => import("../views/Count2View.vue"),
      meta: {
        requiresAuth: false,
        title: "Counter 2 / Taxi",
      },
    },
    {
      path: "/login",
      name: "login",
      component: () => import("../views/LoginView.vue"),
      meta: {
        requiresAuth: false,
        title: "Login / Taxi",
      },
    },
    {
      path: "/:pathMatch(.*)*",
      name: "PageNotFound",
      component: () => import("../views/404View.vue"),
      meta: {
        requiresAuth: false,
        title: "404 / Taxi",
      },
    },
  ],
});

export default router;
