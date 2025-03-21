<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khám Phá Việt Nam</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        * {
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }
        body {
            background-color: #f4f4f4;
            color: #333;
        }
        header {
            background: linear-gradient(45deg, #007BFF, #00C6FF);
            color: white;
            text-align: center;
            padding: 20px;
            font-size: 28px;
            font-weight: 600;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }
        .container {
            max-width: 800px;
            margin: 30px auto;
            padding: 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease-in-out;
        }
        .container:hover {
            transform: scale(1.02);
        }
        h2 {
            font-weight: 600;
            color: #007BFF;
        }
        button {
            background: #ff5722;
            color: white;
            border: none;
            padding: 12px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
            transition: background 0.3s;
        }
        button:hover {
            background: #e64a19;
        }
        .place-info {
            margin-top: 20px;
            text-align: center;
        }
        .place-info img {
            max-width: 100%;
            border-radius: 10px;
            margin-top: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        textarea, input {
            width: 100%;
            margin-top: 10px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        #map {
            width: 100%;
            height: 300px;
            margin-top: 10px;
            border-radius: 10px;
        }
    </style>
</head>
<body>

<header>Khám Phá Việt Nam</header>

<div class="container">
    <h2>Gợi ý địa điểm du lịch</h2>
    <button onclick="suggestPlace()">Gợi ý ngay!</button>
    <div class="place-info" id="place-info">
        <p>Nhấn nút để nhận gợi ý du lịch thú vị!</p>
    </div>
    <div id="map"></div>
</div>

<div class="container">
    <h2>Chia sẻ trải nghiệm của bạn</h2>
    <input type="text" id="username" placeholder="Tên của bạn">
    <textarea id="userPost" placeholder="Viết về chuyến đi của bạn..."></textarea>
    <button onclick="shareExperience()">Đăng bài</button>
    <div id="shared-posts"></div>
</div>

<script>
    const places = [
        { 
            name: "Đảo Lý Sơn", 
            image: "https://upload.wikimedia.org/wikipedia/commons/5/52/Ly_Son_Island.jpg", 
            review: "Hòn đảo tuyệt đẹp với làn nước trong xanh và hải sản tươi ngon.", 
            food: "Gỏi tỏi Lý Sơn",
            lat: 15.3909, 
            lng: 109.1112
        },
        { 
            name: "Thác Bản Giốc", 
            image: "https://upload.wikimedia.org/wikipedia/commons/2/2a/Ban_Gioc_Falls.jpg", 
            review: "Thác nước hùng vĩ nằm giữa biên giới Việt - Trung.", 
            food: "Vịt quay 7 vị Cao Bằng",
            lat: 22.8531, 
            lng: 106.7223
        },
        { 
            name: "Mù Cang Chải", 
            image: "https://upload.wikimedia.org/wikipedia/commons/e/ee/Mu_Cang_Chai_Rice_Terraces.jpg", 
            review: "Ruộng bậc thang kỳ vĩ, điểm đến lý tưởng vào mùa lúa chín.", 
            food: "Cơm lam Tây Bắc",
            lat: 21.7925, 
            lng: 104.1413
        }
    ];

    function suggestPlace() {
        const randomIndex = Math.floor(Math.random() * places.length);
        const place = places[randomIndex];
        document.getElementById("place-info").innerHTML = `
            <h3>${place.name}</h3>
            <img src="${place.image}" alt="${place.name}">
            <p><strong>Đánh giá:</strong> ${place.review}</p>
            <p><strong>Ẩm thực nổi bật:</strong> ${place.food}</p>
        `;
        updateMap(place.lat, place.lng);
    }

    function updateMap(lat, lng) {
        const mapElement = document.getElementById("map");
        mapElement.innerHTML = `<iframe width="100%" height="100%" 
            src="https://maps.google.com/maps?q=${lat},${lng}&z=12&output=embed">
        </iframe>`;
    }

    function shareExperience() {
        const username = document.getElementById("username").value.trim();
        const userText = document.getElementById("userPost").value.trim();
        if (!username || !userText) {
            alert("Vui lòng nhập tên và nội dung chia sẻ!");
            return;
        }

        const postContainer = document.getElementById("shared-posts");
        const newPost = document.createElement("div");
        newPost.style.border = "1px solid #ddd";
        newPost.style.padding = "10px";
        newPost.style.marginTop = "10px";
        newPost.style.borderRadius = "5px";
        newPost.style.boxShadow = "0 4px 8px rgba(0, 0, 0, 0.1)";
        newPost.innerHTML = <strong>${username}:</strong> <p>${userText}</p>;
        postContainer.prepend(newPost);
        savePost({ username, text: userText });
        document.getElementById("userPost").value = "";
    }

    function savePost(post) {
        let posts = JSON.parse(localStorage.getItem("posts")) || [];
        posts.unshift(post);
        localStorage.setItem("posts", JSON.stringify(posts));
    }

    function loadPosts() {
        let posts = JSON.parse(localStorage.getItem("posts")) || [];
        const postContainer = document.getElementById("shared-posts");
        posts.forEach(({ username, text }) => {
            const newPost = document.createElement("div");
            newPost.innerHTML = <strong>${username}:</strong> <p>${text}</p>;
            postContainer.appendChild(newPost);
        });
    }

    document.addEventListener("DOMContentLoaded", loadPosts);
</script>

</body>
</html>
