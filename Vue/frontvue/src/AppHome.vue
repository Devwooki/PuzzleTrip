<template>
    <v-card flat tile class="mainCard">
        <v-window v-model="onboarding" class="overImg">
            <v-window-item v-for="n in length" :key="`card-${n}`">
                <v-card color="red">
                    <v-row>
                        <img :src="require(`@/assets/mainSlice/${n}.jpg`)">
                    </v-row>
                </v-card>
            </v-window-item>
        </v-window>
<!--        <div class="dogSpell1">바보는 방황하고, 현명한 사람은 여행한다</div>-->
<!--        <div class="dogSpell2">- 풀러-</div>-->
        <div class="mainComent">
            <div class="overLap1">
                <div class="popHead">대전</div>
                <div class="popMain">성심당</div>
                <div class="ment">피고, 청춘이 하는 희망의 이것을 불어 가는 끝에 열락의 그리하였는가? 것이 너의 그들의 얼마나 이상 위하여서, 있음으로써 피고, 있는가?
                </div>
                <button class="goTo">VIEW</button>
                <img :src="require(`@/assets/mainSlice/3.jpg`)">
            </div>

            <div class="overLap2">
                <div class="popHead">경기도</div>
                <div class="popMain">영월</div>
                <div class="ment"> 가는 찾아다녀도, 우리의 살았으며, 사막이다. 희망의 그들은 인간이 곧 창공에 때까지 따뜻한 내려온 크고 끓는다. 수 사랑의 그들은 있으랴?
                </div>
                <button class="goTo">VIEW</button>
                <img :src="require(`@/assets/mainSlice/4.jpg`)">
            </div>

            <div class="overLap3">
                <div class="popHead">세종</div>
                <div class="popMain">턱별시</div>
                <div class="ment"> 인생의 가는 이상의 어디 평화스러운 인간이 싹이 것이다. 눈에 소담스러운 할지라도 찾아 피어나기 위하여 무엇을 품에 것이다. .
                </div>
                <button class="goTo">VIEW</button>
                <img :src="require(`@/assets/mainSlice/1.jpg`)">
            </div>

            <div class="overLap4">
                <div class="popHead">서울</div>
                <div class="popMain">가고싶다</div>
                <div class="ment"> 품고 몸이 얼마나 찾아다녀도, 하였으며, 이것이다. 할지니, 소담스러운 청춘은 석가는 청춘 피는 같은 철환하였는가? 구하기 이상은 청춘이 따뜻한 몸이
                    피가 기쁘며, 것이다.
                </div>
                <button class="goTo">VIEW</button>
                <img :src="require(`@/assets/mainSlice/2.jpg`)">
            </div>


        </div>
        <v-card-actions class="v-card-actions">
            <v-btn text @click="prev">
                <v-icon>mdi-chevron-left</v-icon>
            </v-btn>
            <v-item-group v-model="onboarding" class="text-center" mandatory>
                <v-item v-for="n in length" :key="`btn-${n}`" v-slot="{ active, toggle }"
                >
                    <v-btn :input-value="active" icon @click="toggle">
                        <v-icon>mdi-record</v-icon>
                    </v-btn>
                </v-item>
            </v-item-group>
            <v-btn text @click="next">
                <v-icon>mdi-chevron-right</v-icon>
            </v-btn>
        </v-card-actions>
    </v-card>
</template>
<script>
export default {
    data: () => ({
        length: 8,
        onboarding: 0,
    }),
    methods: {
        next() {
            this.onboarding = this.onboarding + 1 === this.length
                ? 0
                : this.onboarding + 1
        },
        prev() {
            this.onboarding = this.onboarding - 1 < 0
                ? this.length - 1
                : this.onboarding - 1
        },
    },
    mounted() {
        setInterval(() => {
            this.next();
        }, 5000);
    },
};
</script>
<style scoped>

@font-face {
    font-family: 'SUITE-Regular';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
    font-weight: 400;
    font-style: normal;
}
.dogSpell1 {
    border-radius: 3px;
    padding-left: 15px;
    height: 96px;
    width: 700px;
    position: absolute;
    font-size: 40px;
    top: 150px;
    left: 200px;
    color: #27374D;
}
.dogSpell2 {
    position: absolute;
    font-size: 35px;
    top: 200px;
    left: 800px;
    color: #27374D;
}
.mainComent * {
    font-family: 'SUITE-Regular';
}
.mainComent img {
    position: absolute;
    bottom: 0;
    width: inherit;
    height: initial;
    border-bottom-left-radius: 5px;
    border-bottom-right-radius: 5px;
}
.overImg {
    position: relative;
}

.overLap1, .overLap2, .overLap3, .overLap4 {
    background-color: #EFF5F5;
    position: absolute;
    top: 380px;
    width: 230px;
    height: 370px;
    border-radius: 5px;
}

.overLap1 {
    left: 23%;

}

.overLap2 {
    left: 38%;
}

.overLap3 {
    left: 53%;
}

.overLap4 {
    left: 68%;
}

.popHead {
    font-size: 20px;
    text-align: center;
    margin-top: 15px;
    color: #9E6F21;
}

.popMain {
    font-size: 25px;
    text-align: center;
    margin-top: 5px;
    font-weight: 500;
}

.ment {
    margin: 0 10px;
    margin-top: 5px;
    font-size: 15px;
}
.goTo {
    width: 100px;
    height: 40px;
    position: absolute;
    bottom: 140px;
    left: 70px;
    display: block;
    border: 2px solid #497174;
    font-weight: 700;
    background-color: #EFF5F5;

}

img {
    width: 100%;
    height: 900px;
}

.v-card-actions {
    margin-top: -3rem;
    justify-content: center;
}
</style>