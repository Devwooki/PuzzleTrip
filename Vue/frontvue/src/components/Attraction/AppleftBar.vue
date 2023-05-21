<template>
    <div id="app">
        <div class="selectedSido">{{ selectedSido }}</div>

        <v-expansion-panels v-model="panel" :disabled="disabled" multiple class="calBox">
            <v-expansion-panel>
                <v-expansion-panel-header>여행 일정 정하기</v-expansion-panel-header>
                <v-expansion-panel-content class="calBox">
                    <v-row>
                        <v-col >
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
            <v-btn @click="showPlan">목록 출력</v-btn>
        </div>
    </div>
</template>

<script>
import {mapGetters} from "vuex";

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
    // props: {
    //     selectedSido: {
    //         type: String,
    //         default: '',
    //     },
    //     selectedGugun: {
    //         type: String,
    //         default: '',
    //     },
    //     startPoint: {
    //         type: String,
    //         default: '',
    //     },
    //     endPoint: {
    //         type: String,
    //         default: '',
    //     },
    // },
    computed: {
        ...mapGetters('attractionStore', ['getLeftSelectedSido', 'getLeftSelectedGugun',
            'getLeftStartPoint', 'getLeftEndPoint',
            'getAttractionList']),
        dateRangeText() {
            return this.dates.join(' ~ ')
        },
    },
    methods: {
        showPlan(){
            console.log("추가한 여향지 목록 보여준다")
            console.log(this.getAttractionList)
        }
    },
};
</script>

<style scoped>
.selectedSido {
    text-align: center;
    margin-top: 10px;
    margin-left: 30px;
    font-size: 30px;
}
.calBox {
    width: 325px !important;
}
</style>