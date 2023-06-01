<template>
  <div class="container">
    <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
      <div
        class="col"
        v-for="(pizza, index) in pizzasData"
        :key="`pizza${index}`"
      >
        <div class="card">
          <img
            :src="`../../public/${pizza.nev}${pizza.meret}.jpg`"
            class="card-img-top"
            alt="pizza image"
          />
          <div class="card-body">
            <h5 class="card-title">{{ pizza.nev }}</h5>
            <p class="card-text">
              Méret: {{ pizza.meret }} cm <br />
              Ár: {{ pizza.ar }} Ft
            </p>

            <button
              v-if="storeLogin.loginSuccess"
              type="button"
              class="btn btn-dark"
              @click="onClickNew(pizza.id)"
            >
              Megrendelés
            </button>
          </div>
        </div>
      </div>
    </div>

    <!--#region Modal -->
    <!-- Button trigger modal -->

    <!-- Modal -->
    <div
      class="modal fade"
      id="modalpizza"
      tabindex="-1"
      aria-labelledby="exampleModalLabel"
      aria-hidden="true"
    >
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">Rendelés</h1>
            <button
              type="button"
              class="btn-close"
              data-bs-dismiss="modal"
              aria-label="Close"
            ></button>
          </div>
          <div class="modal-body">
            <form  class="row g-3 needs-validation" novalidate>
              <!-- Név, cim -->
              <div class="mb-3">
                <select
                  v-model="editableCimek.cimid"
                  class="form-select"
                  aria-label="Default select example"
                  required
                >
                  <option
                    v-for="(nevUtcaHsz, index) in nevUtcaHszok"
                    :key="`nuh${index}`"
                    :value="nevUtcaHsz.id"
                  >
                    {{ nevUtcaHsz.nevcim }}
                  </option>
                </select>
                <div class="invalid-feedback">A select kitöltése kötelező</div>
              </div>
              <div class="mb-3">
                <label for="darab" class="form-label">Darab</label>
                <input
                  type="number"
                  class="form-control"
                  id="darab"
                  v-model="editableCimek.darab"
                  required
                />
                <div class="invalid-feedback">A darab kitöltése kötelező</div>
              </div>

              <div class="mb-3">
                <label for="szallitas" class="form-label">Szállitás</label>
                <input
                  type="datetime-local"
                  class="form-control"
                  id="szallitas"
                  v-model="editableCimek.szallitas"
                  required
                />
                <div class="invalid-feedback">A szállitás kitöltése kötelező</div>
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button
              type="button"
              class="btn btn-danger"
              data-bs-dismiss="modal"
            >
              Bezárás
            </button>
            <button
              type="button"
              class="btn btn-secondary"
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
import { storeToRefs } from "pinia";
import { useKeresStore } from "@/stores/keres";
const storeKeres = useKeresStore();
const { keresoszo } = storeToRefs(storeKeres);
const storeUrl = useUrlStore();
const storeLogin = useLoginStore();

class Cimek {
  constructor(pizzaid = null, darab = null, cimid = null, szallitas = null) {
    this.pizzaid = pizzaid;
    this.darab = darab;
    this.cimid = cimid;
    this.szallitas = szallitas;
  }
}

export default {
  data() {
    return {
      keresoszo,
      storeUrl,
      cimek: [],
      editableCimek: new Cimek(),
      storeLogin,
      pizzasData: [],
      stateTitle: "modalcim",
      modal: null,
      state: "view",
      form: null,
      nevUtcaHszok: [],
      rendelPizzaId: null,
    };
  },
  mounted() {
    this.getCimek();
    this.getPizzas();
    this.getNevUtcaHsz();
    this.modal = new bootstrap.Modal(document.getElementById("modalpizza"), {
      keyboard: false,
    });

    this.form = document.querySelector(".needs-validation");
  },
  watch: {
    keresoszo() {
      if (this.keresoszo.trim()) {
        this.getPizzasSzur();
      } else {
        this.getPizzas();
      }
    },
  },
  computed: {
    pizzas() {
      return this.pizzasData.map((pizza) => ({
        name: pizza.nev,
        size: pizza.meret,
        price: pizza.ar,
        image:
          "https://www.mindmegette.hu/images/311/O/kemences-pizza-fekvo.jpg",
      }));
    },
  },

  methods: {
    async getCimek() {
      let url = this.storeUrl.urlCimek;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.cimek = data.data;
      // this.cars = data.data.map((car) => {
      //   car.outOfTraffic = car.outOfTraffic === 1;
      //   return car;
      // });
    },

    async getPizzas() {
      const url = this.storeUrl.urlPizzak;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.pizzasData = data.data;
    },
    async getPizzasSzur() {
      const url = `${this.storeUrl.urlPizzakKeres}/${this.keresoszo}`;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.pizzasData = data.data;
    },
    async getNevUtcaHsz() {
      const url = this.storeUrl.urlNevUtcaHsz;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.nevUtcaHszok = data.data;
    },

    onClickNew(id) {
      this.rendelPizzaId = id;
      this.editableCimek = new Cimek();
      this.editableCimek.pizzaid = this.rendelPizzaId;
      this.state = "new";
      this.modal.show();
    },
    onClickCancel() {
      this.modal.hide();
    },
    onClickSave() {
      this.form.classList.add("was-validated");
      if (this.form.checkValidity()) {
        if (this.state == "edit") {
          //put
          this.putNevUtcaHsz();
          // this.modal.hide();
        } else if (this.state == "new") {
          //post
          this.postNevUtcaHsz();
          // this.modal.hide();
        }
        this.modal.hide();
        this.getNevUtcaHsz();
      }
    },

    async postNevUtcaHsz() {
      let url = this.storeUrl.urlRendeles;
      const body = JSON.stringify(this.editableCimek);
      console.log(url, body);
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
      console.log("x", data.data);
      this.getNevUtcaHsz();
    },
    async putNevUtcaHsz() {
      const id = this.editableCimek.id;
      let url = `${this.storeUrl.urlNevUtcaHsz}/${id}`;
      const body = JSON.stringify(this.editableCimek);
      const config = {
        method: "PUT",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
        body: body,
      };
      const response = await fetch(url, config);
      this.getNevUtcaHsz();
    },
  },
};
</script>

<style>
.card {
  margin-bottom: 20px;
}
.card-img-top {
  border-radius: 5px;
}
.card-title {
  margin-bottom: 10px;
}
.card-text {
  margin-bottom: 5px;
}
.btn-primary {
  margin-top: 10px;
}
</style>