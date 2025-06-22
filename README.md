#  💡 資料庫系統期末作業成果展示

>  題目： 📚 圖書借閱管理系統
- 姓名：黃鈺棋  
- 學號：410631633  
- 系級：資管系四年級  

---

## ✨ 系統概述

本系統模擬圖書館的基本借閱流程，包含「借書」、「還書」、「查詢紀錄」等功能。  
系統設計採用三張資料表 `User`、`Book`、`Borrow`，並使用正規化（3NF）規則設計欄位結構與關聯性。

---

## 📁 資料表設計概念

- **User 表**：儲存學生資訊（學號、姓名、Email）
- **Book 表**：儲存書籍資料，包含書名、作者、ISBN 及是否可借欄位（available）
- **Borrow 表**：紀錄每一次借閱，欄位包括學生、書籍、借閱日、歸還日

這三張表具備主外鍵關聯設計，可維持資料一致性與查詢彈性。

---

📘 ER 圖｜圖書借閱管理系統

本系統包含 3 張資料表與 1 個視圖：
- User：學生資料
- Book：書籍資訊
- Borrow：借閱紀錄，記錄每次借書還書
- View_Unreturned：查詢尚未歸還的借書資料
![image](https://hackmd.io/_uploads/B1_m8uSElx.png)
![image](https://hackmd.io/_uploads/rkqm8OS4gl.png)

---

## 🔨 資料建置流程（🖼 對應截圖1）

✅ *步驟 1：建立資料庫與三張資料表*  
📷User / Book / Borrow 表格建立 SQL 程式碼與結構確認畫面  
![image](https://hackmd.io/_uploads/HJXYMuHVlg.png)


✅ *步驟 2：插入範例資料（5 位學生、5 本書、7 筆借書紀錄）*  
📷SELECT * FROM User / Book / Borrow 查詢結果
![image](https://hackmd.io/_uploads/S183GOSEle.png)


這些資料中，有部分紀錄尚未填入 `return_date`，代表仍在外借中。

---

## 🔍 查詢未歸還書籍（🖼 對應截圖3）

系統支援使用 `JOIN` 搭配條件查詢尚未歸還的借書紀錄：

查詢邏輯說明：
- 結合 `User`、`Book`、`Borrow` 三張資料表
- 條件為 `Borrow.return_date IS NULL`
- 顯示學生姓名、書名與借閱日期

📷查詢尚未歸還書籍畫面  
![image](https://hackmd.io/_uploads/S1m-XdSVgg.png)

📷查詢結果（1～2 筆尚未歸還資料）
![image](https://hackmd.io/_uploads/HJkmmuHVee.png)

---

## 👁 建立視圖 View_Unreturned（🖼 對應截圖5）

系統另設計一個名為 `View_Unreturned` 的 SQL 視圖（View），目的在於簡化「未歸還書籍查詢」的複雜度。

建立視圖後，未來只需下 `SELECT * FROM View_Unreturned` 即可快速查出尚未歸還的資料。

📷![image](https://hackmd.io/_uploads/rk4WE_SEee.png)


---

## 🔁 書籍還書功能（🖼 對應截圖6～8）

設計一個「還書流程」，包含兩個操作：
1. 將 `Borrow.return_date` 補上今天日期
2. 將對應 `Book.available` 改為 TRUE

並使用 `START TRANSACTION ... COMMIT` 確保兩步驟同時成功，避免資料不一致。

📷9還書前資料畫面（return_date 為 NULL）  
![image](https://hackmd.io/_uploads/SJ-FVuHNel.png)

📷執行還書 SQL 程式碼畫面  
![image](https://hackmd.io/_uploads/r16mSdSEeg.png)

📷還書後結果（return_date 有值、Book.available 改為 TRUE）
![image](https://hackmd.io/_uploads/HJg5HOHNee.png)
![image](https://hackmd.io/_uploads/HyZjH_SElx.png)


---

## 📌 額外查詢功能：目前借出書籍（🖼 對應截圖9）

利用 `Book.available = FALSE` 條件查詢目前仍在外借中的書籍清單。

📷【截圖 9】SELECT title FROM Book WHERE available = FALSE 查詢畫面

這個功能可以快速列出圖書館有哪些書正在外借。

---

## 💬 系統設計總結

本系統設計目標在於簡化並模擬真實的借書場景，藉由三張正規化資料表，搭配關聯查詢、視圖與交易控制，達到以下目的：

- 使用 JOIN 查詢跨表資訊  
- 利用視圖簡化常用查詢  
- 使用交易機制維護資料一致性  
- 模擬還書更新流程，控制書籍借出狀態  

整體功能符合作業規範，並可輕易擴充進階功能（如：觸發器、自動提醒等）。




