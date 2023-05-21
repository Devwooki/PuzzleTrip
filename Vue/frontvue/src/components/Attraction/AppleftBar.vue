<template>
  <div id="app">
    <div class="selectedSido">{{ selectedSido }}</div>

    <v-expansion-panels v-model="panel" :disabled="disabled" multiple  >
      <v-expansion-panel>
        <v-expansion-panel-header>여행 일정 정하기</v-expansion-panel-header>
        <v-expansion-panel-content>
          <v-row>
            <v-col>
              <v-date-picker v-model="dates" range></v-date-picker>
            </v-col>

          </v-row>
        </v-expansion-panel-content>
      </v-expansion-panel>
    </v-expansion-panels>
    <v-col>
      <v-text-field
          v-model="dateRangeText"
          label="여행일정"
          prepend-icon="mdi-calendar"
          readonly>
      </v-text-field>
    </v-col>
    <div class="moveLoc">

    </div>
  </div>
</template>

<script>
export default {
  name: 'AppLeftBar',
  components: {},
  data() {
    return {
      dates: ['2023-05-10', '2023-05-20'],
      panel: [0, 1],
      disabled: false,
      readonly: false,
    };
  },
  props: {
    selectedSido: {
      type: String,
      default: '',
    },
    selectedGugun: {
      type: String,
      default: '',
    },
    startPoint: {
      type: String,
      default: '',
    },
    endPoint: {
      type: String,
      default: '',
    },
  },
  computed: {
    dateRangeText() {
      return this.dates.join(' ~ ')
    },
  },
  methods: {
  },
};
</script>

<style scoped>
.selectedSido {
    text-align: center;
    margin: 20px 20px;
    font-size: 30px;
}
</style>