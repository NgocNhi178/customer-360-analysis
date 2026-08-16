# Customer 360 Analysis

## 1. Tổng quan

**Customer 360 Analysis** là project phân tích dữ liệu khách hàng nhằm đánh giá **giá trị, mức độ tương tác và tình trạng hoạt động của khách hàng** thông qua phương pháp **RFM Analysis**.

Project tập trung vào việc phân khúc khách hàng dựa trên hành vi giao dịch, từ đó xác định các nhóm khách hàng có giá trị cao, khách hàng có tiềm năng phát triển và các nhóm có nguy cơ giảm tương tác hoặc rời bỏ.

---

## 2. Mục tiêu phân tích

Project được thực hiện nhằm trả lời các câu hỏi:

- Khách hàng đang có những đặc điểm và hành vi giao dịch như thế nào?
- Nhóm khách hàng nào tạo ra giá trị giao dịch cao nhất?
- Nhóm khách hàng nào có mức độ tương tác tốt?
- Những khách hàng có giá trị cao nhưng đang giảm tương tác là ai?
- Doanh nghiệp nên ưu tiên duy trì và phát triển nhóm khách hàng nào?
- Có thể sử dụng phân khúc khách hàng để đề xuất các hoạt động chăm sóc và giữ chân khách hàng như thế nào?

---

## 3. Dữ liệu

Project sử dụng hai nguồn dữ liệu chính:

### Customer_Registered

Chứa thông tin khách hàng đã đăng ký thành viên.

### Customer_Transaction

Chứa thông tin giao dịch của khách hàng trong giai đoạn từ **06/2022 đến 08/2022**.

Các trường dữ liệu chính:

| Trường | Mô tả |
|---|---|
| ID | Mã giao dịch |
| CustomerID | Mã khách hàng |
| Purchase_Date | Ngày giao dịch |
| GMV | Giá trị giao dịch |

Dữ liệu gốc không được đưa lên repository GitHub.

Chi tiết về dữ liệu và cách xử lý được trình bày tại:

`Data/README.md`

---

## 4. Phương pháp phân tích

### 4.1. RFM Analysis

Project sử dụng mô hình RFM để đánh giá khách hàng dựa trên ba khía cạnh:

### Recency

Số ngày kể từ lần giao dịch gần nhất của khách hàng.

- Recency thấp → khách hàng giao dịch gần đây
- Recency cao → khách hàng đã lâu chưa giao dịch

### Frequency

Tổng số giao dịch của khách hàng trong khoảng thời gian phân tích.

- Frequency cao → khách hàng giao dịch thường xuyên hơn

### Monetary

Tổng giá trị giao dịch (GMV) mà khách hàng tạo ra trong khoảng thời gian phân tích.

- Monetary cao → khách hàng có giá trị giao dịch cao hơn

---

## 5. RFM Scoring

Các chỉ số RFM được chia thành các nhóm theo phương pháp **Quartile** và được chấm điểm từ 1 đến 4.

### Recency

Recency được chấm điểm theo chiều ngược:

- Recency thấp → R_score cao
- Recency cao → R_score thấp

Điều này phản ánh rằng khách hàng giao dịch càng gần đây thì mức độ hoạt động càng tốt.

### Frequency và Monetary

Frequency và Monetary được chấm điểm theo chiều thuận:

- Giá trị thấp → Score thấp
- Giá trị cao → Score cao

Các điểm R, F và M sau đó được kết hợp để tạo thành **RFM Score**.

---

## 6. Phân khúc khách hàng

Dựa trên RFM Score, khách hàng được phân thành 7 nhóm:

| Phân khúc | Đặc điểm |
|---|---|
| VIP | Khách hàng có mức độ tương tác và giá trị cao |
| THÂN THIẾT | Khách hàng có mức độ gắn kết tốt và có khả năng tiếp tục phát triển |
| KHÔNG THỂ MẤT | Khách hàng có giá trị cao nhưng đã lâu chưa quay lại |
| KHÁCH MỚI | Khách hàng mới có hoạt động giao dịch |
| TIỀM NĂNG | Khách hàng có dấu hiệu tích cực và có khả năng phát triển |
| NGUY CƠ MẤT | Khách hàng có dấu hiệu giảm mức độ tương tác |
| NGỦ ĐÔNG | Khách hàng có mức độ tương tác và giá trị thấp |

Các phân khúc được sử dụng để đánh giá giá trị khách hàng, mức độ tương tác và xác định cơ hội duy trì hoặc phát triển khách hàng.

---

## 7. Các phát hiện chính

### 7.1. Giá trị khách hàng tập trung ở một số phân khúc

GMV có sự khác biệt đáng kể giữa các nhóm khách hàng.

Nhóm **VIP** và **THÂN THIẾT** đóng góp phần lớn GMV, cho thấy một số nhóm khách hàng có vai trò quan trọng đối với tổng giá trị giao dịch.

Tuy nhiên, các nhóm **NGUY CƠ MẤT** và **NGỦ ĐÔNG** vẫn tạo ra một lượng GMV đáng kể.

Điều này cho thấy việc chỉ tập trung vào khách hàng VIP là chưa đủ; doanh nghiệp cũng cần quan tâm đến các nhóm khách hàng có giá trị nhưng đang có dấu hiệu giảm tương tác.

---

### 7.2. Nhóm VIP có giá trị giao dịch cao nhất

Nhóm **VIP** có giá trị giao dịch trung bình cao nhất và mức Recency tương đối thấp.

Điều này cho thấy nhóm VIP vừa có giá trị cao vừa duy trì hoạt động giao dịch tương đối gần đây.

Đây là nhóm cần được ưu tiên trong các hoạt động duy trì quan hệ và phát triển giá trị khách hàng.

---

### 7.3. Nhóm "Không thể mất" cần được ưu tiên retention

Nhóm **KHÔNG THỂ MẤT** có giá trị giao dịch trung bình cao nhưng Recency cao hơn đáng kể so với nhóm VIP.

Điều này cho thấy đây là nhóm khách hàng có giá trị nhưng đã lâu chưa quay lại giao dịch.

Đây là nhóm cần được ưu tiên trong các hoạt động **retention và re-engagement** nhằm hạn chế nguy cơ mất doanh thu từ khách hàng có giá trị cao.

---

### 7.4. Cơ hội không chỉ nằm ở khách hàng có giá trị cao nhất

Phân tích cho thấy quy mô khách hàng và giá trị khách hàng không hoàn toàn giống nhau.

Một nhóm có số lượng khách hàng lớn không nhất thiết tạo ra giá trị cao nhất, trong khi một nhóm có quy mô nhỏ hơn có thể đóng góp đáng kể vào GMV.

Do đó, doanh nghiệp nên kết hợp cả:

- Quy mô khách hàng
- Giá trị giao dịch
- Mức độ tương tác
- Nguy cơ giảm hoạt động

khi xây dựng chiến lược chăm sóc khách hàng.

---

## 8. Đề xuất kinh doanh

Dựa trên kết quả phân tích, có thể ưu tiên các nhóm khách hàng theo hướng:

### VIP

- Duy trì trải nghiệm và mức độ gắn kết
- Ưu tiên chương trình chăm sóc khách hàng giá trị cao
- Khuyến khích tăng giá trị giao dịch và duy trì tần suất

### THÂN THIẾT

- Tăng cường các chương trình loyalty
- Khuyến khích khách hàng tăng tần suất và giá trị giao dịch
- Xác định khách hàng có khả năng chuyển lên nhóm VIP

### KHÔNG THỂ MẤT

- Ưu tiên các chiến dịch retention
- Re-engagement khách hàng đã lâu chưa giao dịch
- Cá nhân hóa ưu đãi dựa trên lịch sử giao dịch

### TIỀM NĂNG

- Tăng cường tương tác
- Khuyến khích giao dịch lặp lại
- Xây dựng chương trình nhằm tăng Frequency và Monetary

### NGUY CƠ MẤT

- Triển khai chiến dịch kích hoạt lại khách hàng
- Xác định nguyên nhân giảm giao dịch
- Sử dụng ưu đãi phù hợp để khuyến khích quay lại

### NGỦ ĐÔNG

- Thực hiện các chiến dịch reactivation với chi phí phù hợp
- Đánh giá hiệu quả trước khi đầu tư nguồn lực lớn
- Xác định khách hàng còn tiềm năng để ưu tiên chăm sóc

---

## 9. Dashboard

Project gồm 2 dashboard chính:

### Dashboard 1 — Overview

Cung cấp góc nhìn tổng quan về:

- Tổng số khách hàng
- Tổng GMV
- Tổng số giao dịch
- AOV
- Xu hướng giao dịch theo thời gian
- Một số chỉ số tổng quan về khách hàng

### Dashboard 2 — Customer Segmentation & RFM Analysis

Tập trung vào:

- Phân phối RFM
- RFM Score
- Phân khúc khách hàng
- Average Recency
- Average Frequency
- Average Monetary
- Customer Count theo từng phân khúc
- GMV theo từng phân khúc

---

## 10. Công cụ sử dụng

- **SQL**
  - JOIN
  - CTE
  - CASE WHEN
  - Aggregate Functions
  - Window Functions
- **Google BigQuery**
- **Power BI**
- **DAX**
- **Microsoft Excel**

---

## 11. Cấu trúc repository

```text
customer-360-analysis/
│
├── README.md
│
├── SQL/
│   └── v_rfm.sql
│
├── PowerBI/
│   └── customer360.pbix
│
├── Data/
│   └── README.md
│
├── Report/
│   └── Customer360Report.pdf
│
└── screenshots/
    ├── CUSTOMER SEGMENTATION & RFM ANALYSIS.png
    └── OVERVIEW.png
