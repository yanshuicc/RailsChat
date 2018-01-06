/**
 * Created by admin on 2018/1/5.
(function () {
    window.setInterval(fri_req, 3000);

    function fri_req()
    {
        $.ajax({
            url:"/friendships/index_json",
            success: function(data) {
                if(data.length()==0){}
                else{
                    data[0]
                }
            },
            async:true
        })
    }

}.call(this))
 */