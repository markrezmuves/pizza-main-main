<template>
  <div>
    <h1>Pizzák kezelése</h1>

    <!--#region táblázat -->
    <div class="my-overflow">
      <table class="table table-bordered table-hover table-dark w-auto">
        <thead>
          <tr>
            <th>
              <!-- New car -->
              <button
                type="button"
                class="btn btn-outline-success btn-sm"
                @click="onClickNew()"
              >
                Új pizza
              </button>
            </th>
            <th>Pizza fajtája</th>
            <th>Pizza mérete</th>
            <th>Pizza ára</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(pizza, index) in pizzak"
            :key="`pizza${index}`"
            :class="currentRowBackground(pizza.id)"
            @click="onClikRow(pizza.id)"
          >
            <td class="text-nowrap">
              <!-- törlés -->
              <button
                type="button"
                class="btn btn-outline-danger btn-sm"
                @click="onClickDelete(pizza.id)"
              >
                <i class="bi bi-trash3-fill"></i>
              </button>

              <!-- módosítás -->
              <button
                type="button"
                class="btn btn-outline-primary btn-sm ms-2"
                @click="onClickEdit(pizza.id)"
              >
                <i class="bi bi-pencil-fill"></i>
              </button>
            </td>
            <td>{{ pizza.nev }}</td>
            <td>{{ pizza.meret }}</td>
            <td>{{ pizza.ar }}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <!--#endregion táblázat -->

    <!--#region Modal -->
    <div
      class="modal fade"
      id="modalCar"
      tabindex="-1"
      aria-labelledby="modalCarModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content bg-dark text-light">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">
              {{ stateTitle }}
            </h1>
            <button
              type="button"
              class="btn-close btn-close-white"
              @click="onClickCancel()"
              aria-label="Close"
            ></button>
          </div>

          <!--#region Modal body -->
          <div class="modal-body">
            <!--#region Form -->

            <form class="row g-3 needs-validation" novalidate>
              <!-- pizzs név -->
              <div class="col-md-12">
                <label for="nev" class="form-label">Pizza neve</label>
                <input
                  type="text"
                  class="form-control"
                  id="nev"
                  required
                  v-model="editablePizza.nev"
                />
                <div class="invalid-feedback">A pizza név kitöltése kötelező</div>
              </div>

              <!-- pizza mérete  -->
              <div class="col-md-6">
                <label for="meret" class="form-label">A pizza mérete</label>
                <input
                  type="number"
                  class="form-control"
                  id="meret"
                  required
                  v-model="editablePizza.meret"
                />
                <div class="invalid-feedback">
                  A pizza méretének kitöltése kötelező
                </div>
              </div>

              <!-- ar -->
              <div class="col-md-6">
                <label for="ar" class="form-label">Ára</label>
                <input
                  type="number"
                  class="form-control"
                  id="ar"
                  required
                  v-model="editablePizza.ar"
                />
                <div class="invalid-feedback">Az ár kitöltése kötelező</div>
              </div>
            </form>
            <!--#endregion Form -->
          </div>
          <!--#endregion Modal body -->

          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-danger"
              @click="onClickCancel()"
            >
              Bezárás
            </button>
            <button
              type="button"
              class="btn btn-primary"
              @click="onClickSave()"
            >
              Mentés
            </button>
          </div>
        </div>
      </div>
    </div>
    <!--#endregion Modal -->
  </div>
</template>

<script>
import * as bootstrap from "bootstrap";
import { useUrlStore } from "@/stores/url";
import { useLoginStore } from "@/stores/login";
const storeUrl = useUrlStore();
const storeLogin = useLoginStore();

class Pizza {
  constructor(id = 0, nev = null, meret = null, ar = null) {
    this.id = id;
    this.nev = nev;
    this.meret = meret;
    this.ar = ar;
  }
}

export default {
  data() {
    return {
      storeUrl,
      storeLogin,
      pizzak: [],
      editablePizza: new Pizza(),
      modal: null,
      form: null,
      state: "view",
      currentId: null,
      driversAbc: [],
    };
  },
  mounted() {
    this.getPizzak();
    this.getFreeDriversAbc();
    this.modal = new bootstrap.Modal(document.getElementById("modalCar"), {
      keyboard: false,
    });

    this.form = document.querySelector(".needs-validation");
  },
  methods: {
    async getPizzak() {
      let url = this.storeUrl.urlPizzak;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.pizzak = data.data;
    },
    async getPizzaById(id) {
      let url = `${this.storeUrl.urlPizzak}/${id}`;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.editablePizza = data.data;
    },

    async getFreeDriversAbc() {
      let url = this.storeUrl.urlFreeDriversAbc;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.driversAbc = data.data;
    },

    async postPizza() {
      let url = this.storeUrl.urlPizzak;
      const body = JSON.stringify(this.editablePizza);
      const config = {
        method: "POST",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
        body: body,
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.getPizzak();
    },
    async putPizza() {
      const id = this.editablePizza.id;
      let url = `${this.storeUrl.urlPizzak}/${id}`;
      const body = JSON.stringify(this.editablePizza);
      const config = {
        method: "PUT",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
        body: body,
      };
      const response = await fetch(url, config);
      this.getPizzak();
    },
    async deletePizza(id) {
      let url = `${this.storeUrl.urlPizzak}/${id}`;
      const config = {
        method: "DELETE",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      this.getPizzak();
    },
    onClikRow(id) {
      this.currentId = id;
    },
    onClickNew() {
      this.state = "new";
      this.currentId = null;
      this.editablePizza = new Pizza();
      this.modal.show();
    },
    onClickDelete(id) {
      this.state = "delete";
      this.deletePizza(id);
      this.currentId = null;
    },
    onClickEdit(id) {
      this.state = "edit";
      this.getPizzaById(id);
      this.getFreeDriversAbc();
      this.modal.show();
    },
    onClickCancel() {
      this.editablePizza = new Pizza();
      this.modal.hide();
    },
    onClickSave() {
      this.form.classList.add("was-validated");
      if (this.form.checkValidity()) {
        if (this.state === "edit") {
          // put
          this.putPizza();
        } else if (this.state === "new") {
          // post
          this.postPizza();
        }
        this.modal.hide();
        this.getPizzak();
      }
    },
    currentRowBackground(id) {
      return this.currentId === id ? "my-bg-current-row" : "";
    },
    outOfTrafficName(outOfTraffic) {
      return outOfTraffic ? "igen" : "nem";
    },
  },
  computed: {
    stateTitle() {
      if (this.state === "new") {
        return "Új autó bevitele";
      } else if (this.state === "edit") {
        return "Autó módosítása";
      }
    },
  },
};
</script>



<style>
.my-bg-current-row {
  background-color: gray;
}

table {
  background-color: #333333;
  color: white;
}

table th,
table td {
  border-color: #ffffff;
}

tr:hover {
  background-color: #555555;
}

.my-overflow {
  height: 300px;
  overflow-y: scroll;
}

.modal-content {
  background-color: #333333;
  color: white;
}

.modal-header {
  background-color: #222222;
  border-color: #ffffff;
}

.modal-title {
  color: #ffffff;
}

.modal-body {
  background-color: #222222;
  color: white;
}

.modal-footer {
  background-color: #222222;
  border-color: #ffffff;
}

.modal-footer button {
  color: white;
}

.btn-outline-success,
.btn-outline-primary,
.btn-outline-danger {
  color: white;
  border-color: white;
}

.btn-outline-success:hover,
.btn-outline-primary:hover,
.btn-outline-danger:hover {
  color: #333333;
  background-color: white;
}

.btn-danger {
  background-color: #dc3545;
  border-color: #dc3545;
}

.btn-danger:hover {
  background-color: #bb2d3b;
  border-color: #bb2d3b;
}

.btn-primary {
  background-color: #0d6efd;
  border-color: #0d6efd;
}

.btn-primary:hover {
  background-color: #0a58c1;
  border-color: #0a58c1;
}

.btn-close {
  color: white;
}

.invalid-feedback {
  color: white;
}

.form-label {
  color: white;
}
h1{
  color:white;
}
</style>
