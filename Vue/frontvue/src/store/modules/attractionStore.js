const attractionStore = {
    namespaced: true,
    state: {
        //Rigth bar에 필요한 요소
        rightMap: {},
        rightMarkers: {},


        //left bar에 필요한
        leftSelectedSido: '',
        leftSelectedGugun: '',
        StartPoint: '',
        EndPoint: '',
        WayPoint: '',

        //right bar에서 + 버튼 누르면 추가될 리스트
        attractionList: []


    },
    getters: {
        //right bar의 요소 받아오기
        getRightMap(state) {
            return state.rightMap;
        },
        getRightMarkers(state) {
            return state.rightMarkers;
        },


        //left
        getLeftSelectedSido(state) {
            return state.leftSelectedSido
        },
        getLeftSelectedGugun(state) {
            return state.leftSelectedGugun
        },
        getLeftStartPoint(state) {
            return state.StartPoint
        },
        getLeftEndPoint(state) {
            return state.EndPoint
        },

        getAttractionList(state){
            return state.attractionList
        }
    },
    mutations: {
        //right bar요소 셋팅하기
        SET_RIGHT_MAP(state, rightMap) {
            console.log("@@@@@@rightmap 변경 불러오가@@@@@")
            console.log(rightMap)
            state.rightMap = rightMap
        },
        SET_RIGHT_MARKERS(state, rightMarkers) {
            console.log("@@@@@@rightMarkers 변경 불러오가@@@@@")
            console.log(rightMarkers)
            state.rightMarkers = rightMarkers
        },

        //left bar 셋팅하기
        SET_LEFT_SELECTED_SIDO(state, leftSelectedSido){
            state.leftSelectedSido = leftSelectedSido;
        },
        SET_LEFT_SELECTED_GUGUNleft(state,leftSelectedGugun ){
            state.leftSelectedGugun = leftSelectedGugun
        },
        SET_LEFT_START_POINT(state, leftStartPoint){
            state.StartPoint = leftStartPoint
        },
        SET_LEFT_END_POINT(state,leftEndPoint ){
            state.EndPoint = leftEndPoint
        },

        //여행지 추기
        UPDATE_ATTRACTION_LIST(state, marker){
            console.log("업데이트 목록을 볼가?")
            console.log(marker)
            state.attractionList.push(marker)
        }
    },
    actions: {

    }
};

export default attractionStore;
