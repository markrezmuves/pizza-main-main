<template>
  <div>
    <h1>Cím kezelése</h1>

    <!--#region táblázat -->
    <div class="my-overflow">
      <table class="table table-dark table-bordered table-hover w-auto">
        <thead>
          <tr>
            <th>
              <!-- New car -->
              <button
                type="button"
                class="btn btn-outline-success btn-sm"
                @click="onClickNew()"
              >
                Új cím
              </button>
            </th>
            <th>Név</th>
            <th>Utca</th>
            <th>Ház szám</th>
          </tr>
        </thead>
        <tbody>
          <tr
            v-for="(cim, index) in cimek"
            :key="`pizza${index}`"
            :class="currentRowBackground(cim.id)"
            @click="onClikRow(cim.id)"
          >
            <td class="text-nowrap">
              <!-- törlés -->
              <button
                type="button"
                class="btn btn-outline-danger btn-sm"
                @click="onClickDelete(cim.id)"
              >
                <i class="bi bi-trash3-fill"></i>
              </button>

              <!-- módosítás -->
              <button
                type="button"
                class="btn btn-outline-primary btn-sm ms-2"
                @click="onClickEdit(cim.id)"
              >
                <i class="bi bi-pencil-fill"></i>
              </button>
            </td>
            <td>{{ cim.nev }}</td>
            <td>{{ cim.utca }}</td>
            <td>{{ cim.hsz }}</td>
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
      <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">
          <div class="modal-header">
            <h1 class="modal-title fs-5" id="exampleModalLabel">
              {{ stateTitle }}
            </h1>
            <button
              type="button"
              class="btn-close"
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
                <label for="nev" class="form-label">A megrendelő neve</label>
                <input
                  type="text"
                  class="form-control"
                  id="nev"
                  required
                  v-model="editableCimek.nev"
                />
                <div class="invalid-feedback">
                  A megrendelő név kitöltése kötelező
                </div>
              </div>

              <!-- pizza mérete  -->
              <div class="col-md-6">
                <label for="meret" class="form-label">Utca</label>
                <input
                  type="text"
                  class="form-control"
                  id="meret"
                  required
                  v-model="editableCimek.utca"
                />
                <div class="invalid-feedback">Az utca kitöltése kötelező</div>
              </div>

              <!-- házszám -->
              <div class="col-md-6">
                <label for="ar" class="form-label">Házszám</label>
                <input
                  type="number"
                  class="form-control"
                  id="ar"
                  required
                  v-model="editableCimek.hsz"
                />
                <div class="invalid-feedback">A házszám kitöltése kötelező</div>
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

class Cimek {
  constructor(id = 0, nev = null, utca = null, hsz = null) {
    this.id = id;
    this.nev = nev;
    this.utca = utca;
    this.hsz = hsz;
  }
}

export default {
  data() {
    return {
      storeUrl,
      storeLogin,
      cimek: [],
      editableCimek: new Cimek(),
      modal: null,
      form: null,
      state: "view",
      currentId: null,
      driversAbc: [],
    };
  },
  mounted() {
    this.getCimek();
    this.getFreeDriversAbc();
    this.modal = new bootstrap.Modal(document.getElementById("modalCar"), {
      keyboard: false,
    });

    this.form = document.querySelector(".needs-validation");
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
    },

    async getCimekById(id) {
      let url = `${this.storeUrl.urlCimek}/${id}`;
      const config = {
        method: "GET",
        headers: {
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      const data = await response.json();
      this.editableCimek = data.data;
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
    async postCimek() {
      let url = this.storeUrl.urlCimek;
      const body = JSON.stringify(this.editableCimek);
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
      this.getCimek();
    },

    async putCimek() {
      const id = this.editableCimek.id;
      let url = `${this.storeUrl.urlCimek}/${id}`;
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
      this.getCimek();
    },

    async deleteCimek(id) {
      let url = `${this.storeUrl.urlCimek}/${id}`;
      const config = {
        method: "DELETE",
        headers: {
          "content-type": "application/json",
          Authorization: `Bearer ${this.storeLogin.accessToken}`,
        },
      };
      const response = await fetch(url, config);
      this.getCimek();
    },

    onClikRow(id) {
      this.currentId = id;
    },

    onClickNew() {
      this.state = "new";
      this.currentId = null;
      this.editableCimek = new Cimek();
      this.modal.show();
    },

    onClickDelete(id) {
      this.state = "delete";
      this.deleteCimek(id);
      this.currentId = null;
    },

    onClickEdit(id) {
      this.state = "edit";
      this.getCimekById(id);
      this.getFreeDriversAbc();
      this.modal.show();
    },

    onClickCancel() {
      this.editableCimek = new Cimek();
      this.modal.hide();
    },

    onClickSave() {
      this.form.classList.add("was-validated");
      if (this.form.checkValidity()) {
        if (this.state == "edit") {
          this.putCimek();
        } else if (this.state == "new") {
          this.postCimek();
        }
        this.modal.hide();
        this.getCimek();
      }
    },

    currentRowBackground(id) {
      return this.currentId == id ? "my-bg-current-row" : "";
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

<style scoped>
.my-bg-current-row {
  background-color: gray;
}

table {
  background-color: #333;
  color: #fff;
}

thead {
  background-color: #555;
}

tr:hover {
  background-color: #444;
}

tbody tr {
  background-color: #666;
}

.my-overflow {
  height: 300px;
  overflow-y: scroll;
}
h1{
  color:white;
}
</style>
