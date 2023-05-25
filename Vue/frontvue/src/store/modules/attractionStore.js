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
        WayPoint: [],
        Duration: 0,
        Distance: 0,
        //right bar에서 + 버튼 누르면 추가될 리스트
        attractionList: [],
        days: {
            day1: "",
            day2: "",
            day: 0
        },
        dragGroup: [],

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
        getLeftWayPoint(state) {
            return state.WayPoint
        },
        getLeftDistance(state) {
            return state.Distance
        },
        getLeftDuration(state) {
            return state.Duration
        },

        getAttractionList(state){
            return state.attractionList
        },
        getDay(state) {
            return state.days
        },
        getDragGroup(state) {
            return state.dragGroup
        }
    },
    mutations: {
        //right bar요소 셋팅하기
        SET_RIGHT_MAP(state, rightMap) {
            // console.log("@@@@@@rightmap 변경 불러오가@@@@@")
            // console.log(rightMap)
            state.rightMap = rightMap
        },
        SET_RIGHT_MARKERS(state, rightMarkers) {
            // console.log("@@@@@@rightMarkers 변경 불러오가@@@@@")
            // console.log(rightMarkers)
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
        SET_LEFT_WAY_POINT(state,leftWayPoint ){
            state.WayPoint = leftWayPoint
        },
        SET_LEFT_DURATION(state,Duration ){
            state.Duration = Duration
        },
        SET_LEFT_DISTANCE(state,Distance ){
            state.Distance = Distance
        },
        SET_START_END_RESET(state) {
            state.StartPoint = ''
            state.EndPoint = ''
        },
        SET_DIS_DUR_RESET(state) {
            state.Distance = 0
            state.Duration = 0
        },
        //여행 일자 계산 저장
        SET_DAY(state, Days) {
          state.days.day1 = Days.day1
          state.days.day2 = Days.day2
          state.days.day = Days.day
        },
        //여행지 추기
        UPDATE_ATTRACTION_LIST(state, marker){
            console.log("스토어에서 추가 받음",marker)
            state.attractionList.push(marker)
        },
        //여행지 빼기
        UPDATE_ATTRACTION_LIST_MINUS(state, index){
            console.log("스토어에서 삭제 받음",index)
            state.attractionList.splice(index, 1)
        },
        //선택 리스트 초기화
        DELETE_ALL_ATTRACTION(state) {
            state.attractionList.splice(0)
        },
        DELETE_ALL_MARKERS(state) {
            state.rightMarkers.splice(0)
        },
        UPDATE_DRAG_GROUP(state, value) {
            state.dragGroup = value
        }
    },
    actions: {

    }
};

export default attractionStore;
