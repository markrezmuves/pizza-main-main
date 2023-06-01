import { defineStore } from "pinia";

export const useKeresStore = defineStore({
  id: "keres",
  state: () => ({
    keresoszo: null,
  }),
});