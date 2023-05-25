<template>
    <div class="myPage">
        <div class="container">
            <div class="img-align">
                <div class="img-container">
                    <div class="img-profile">
                        <img :src="imgSrc" alt="프로필">
                    </div>
                </div>
            </div>
            <div class="login-content">
                <form>
                    <h2 class="title">{{checkUserInfo.name}}님의 정보</h2>
                    <div class="input-div one">
                        <div>ID :</div>
                        <div class="div">
                            <h5>{{ checkUserInfo.id }}</h5>
                        </div>
                    </div>
                    <div class="input-div one">
                        <div>name :</div>
                        <div class="div">
                            <h5>{{ checkUserInfo.name }}</h5>
                        </div>
                    </div>
                    <div class="input-div pass">
                        <div>Email :</div>
                        <div class="div">
                            <h5>{{ checkUserInfo.email }}</h5>
                        </div>
                    </div>
                    <router-link class="btn"  :to="{name : 'userModify'}">수정하기</router-link>
                    <a class="btn-delete">탈퇴</a>
                </form>
            </div>
        </div>
        <user-like></user-like>
    </div>

</template>

<script>
import {mapActions, mapGetters, mapState} from "vuex";
import UserLike from "@/components/User/UserLike.vue";

export default {
    components: {UserLike},
    data() {
        return {
            imgSrc : ''
        }
    },
    computed: {
        ...mapState('userStore', ["isLogin", "userInfo"]),
        ...mapGetters('userStore', ["checkUserInfo"]),
    },
    methods: {
        ...mapActions('userStore', ['userLogout']),
    },
    created() {
        console.log("@@@마이페이지 접속")
        console.log(this.userInfo.profile)


        if(this.userInfo.profile.saveFolder === null){
            this.imgSrc = `${process.env.VUE_APP_API_BASE_URL}/profilePath/${this.userInfo.profile.saveFile}`
        }else{
             this.imgSrc = `${process.env.VUE_APP_API_BASE_URL}/profilePath/userProfile/${this.userInfo.profile.saveFolder}/${this.userInfo.profile.saveFile}`
        }
    }
}
</script>

<style scoped>
*{
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}

.container{
    width: 100vw;
    height: 550px;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    grid-gap :2rem;
    padding: 0 2rem;
}

.img-align {
    display: flex;
    justify-content: flex-end;
}

.img-container {
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
    overflow: hidden;
}

.img-container .img-profile {
    width: 320px; /* 이미지 크기를 조정할 수 있습니다 */
    height: 320px; /* 이미지 크기를 조정할 수 있습니다 */
    border-radius: 50%;
    overflow: hidden;
    display: flex;
    justify-content: center;
    align-items: center;
    border : 2px solid black;
}

.img-container .img-profile img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.title {
    width: max-content;
}

.login-content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    text-align: center;
}

.img-container img{
    //width: 400px;
    width: 80%;
    height: 60%;
    border-radius: 70%;
    object-fit: cover;
}

form{
    width: 360px;
}

.login-content img{
    height: 100px;
}

.login-content h2{
    margin: 15px auto;
    color: #333;
    text-transform: uppercase;
    font-size: 2.9rem;

}

.login-content .input-div {
    position: relative;
    display: grid;
    grid-template-columns: 15% 70% 15%;
    margin: 25px 0;
    padding: 5px 0;
    border-bottom: 2px solid #d9d9d9;
}

.login-content .input-div.one{
    margin: 0 auto;

}

.input-div > div{
    display: flex;
    justify-content: center;
    align-items: center;
    position: relative;
    height: 45px;
}

.input-div > div > h5{
    position: absolute;
    left: 10px;
    top: 50%;
    transform: translateY(-50%);
    color: #555555;
    font-size: 18px;
    transition: .3s;
}

.input-div:before, .input-div:after{
    content: '';
    position: absolute;
    bottom: -2px;
    width: 0%;
    height: 2px;
    background-color: #38d39f;
    transition: .4s;
}

.input-div:before{
    right: 50%;
}

.input-div:after{
    left: 50%;
}

.input-div.focus:before, .input-div.focus:after{
    width: 50%;
}

.input-div.focus > div > h5{
    top: -5px;
    font-size: 15px;
}

.input-div.focus > .i > i{
    color: #38d39f;
}

.input-div.pass{
    margin :0 auto;
}

a{
    display: block;
    text-align: right;
    text-decoration: none;
    color: #999;
    font-size: 0.9rem;
    transition: .3s;
}

a:hover{
    color: #38d39f;
}

.btn{
    display: flex;
    width: 100%;
    height: 50px;
    border-radius: 25px;
    outline: none;
    border: none;
    background-image: linear-gradient(to right, #7D9600, #a4af6b, #758a0f);
    background-size: 200%;
    font-size: 1.2rem;
    color: #fff;
    text-transform: uppercase;
    margin: 1rem 0;
    cursor: pointer;
    transition: .5s;
    align-items: center;
    justify-content: center;
}
.btn:hover{
    background-position: right;
    justify-content: center;
    color: #fff;
}

.btn-delete{
    display: flex;
    width: 100%;
    height: 50px;
    border-radius: 25px;
    outline: none;
    border: none;
    background-image: linear-gradient(to right, #d96161, #BFA5A5, #ce6969);
    background-size: 200%;
    font-size: 1.2rem;
    color: #fff;
    text-transform: uppercase;
    margin: 1rem 0;
    cursor: pointer;
    transition: .5s;
    align-items: center;
    justify-content: center;
}
.btn-delete:hover{
    background-position: right;
    justify-content: center;
    color: #fff;
}


@media screen and (max-width: 1050px){
    .container{
        grid-gap: 5rem;
    }
}

@media screen and (max-width: 1000px){
    form{
        width: 290px;
    }

    .login-content h2{
        font-size: 2.4rem;
        margin: 8px 0;
    }

    .img img{
        width: 400px;
    }
}

@media screen and (max-width: 900px){
    .container{
        grid-template-columns: 1fr;
    }

    .img{
        display: none;
    }

    .wave{
        display: none;
    }

    .login-content{
        justify-content: center;
    }
}
</style>