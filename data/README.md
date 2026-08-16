# Mô tả dữ liệu

## 1. Tổng quan

Thư mục này chứa tài liệu mô tả các bộ dữ liệu được sử dụng trong project **Customer 360 Analysis**.

Project sử dụng dữ liệu đăng ký khách hàng và dữ liệu giao dịch để xây dựng bộ dữ liệu phân tích ở cấp độ khách hàng và thực hiện phân tích RFM.

---

## 2. Nguồn dữ liệu

### Customer_Registered

Bảng chứa thông tin khách hàng đã đăng ký thành viên.

Bảng này được sử dụng để:

- Xác định danh sách khách hàng
- Kết nối thông tin khách hàng với dữ liệu giao dịch
- Hỗ trợ phân tích ở cấp độ khách hàng

---

### Customer_Transaction

Bảng chứa thông tin các giao dịch của khách hàng trong giai đoạn từ **06/2022 đến 08/2022**.

Mỗi dòng tương ứng với một giao dịch.

Các trường dữ liệu chính:

| Trường        | Mô tả             |
| ------------- | ----------------- |
| ID            | Mã giao dịch      |
| CustomerID    | Mã khách hàng     |
| Purchase_Date | Ngày giao dịch    |
| GMV           | Giá trị giao dịch |

---

## 3. Xử lý dữ liệu

Dữ liệu từ bảng `Customer_Registered` và `Customer_Transaction` được kết nối thông qua trường `CustomerID` để xây dựng bộ dữ liệu phân tích ở cấp độ khách hàng.

Dữ liệu giao dịch sau đó được tổng hợp để tính toán ba chỉ số RFM:

### Recency

Số ngày kể từ lần giao dịch gần nhất của khách hàng.

- Recency thấp → khách hàng vừa giao dịch gần đây
- Recency cao → khách hàng đã lâu chưa giao dịch

### Frequency

Tổng số giao dịch của khách hàng trong khoảng thời gian phân tích, được xem xét trong tương quan với thời gian hoạt động của khách hàng.

- Frequency cao → khách hàng giao dịch thường xuyên hơn

### Monetary

Tổng giá trị giao dịch (GMV) mà khách hàng tạo ra trong khoảng thời gian phân tích.

- Monetary cao → khách hàng có giá trị giao dịch cao hơn

---

## 4. Chấm điểm RFM

Các chỉ số RFM được chia thành các nhóm theo phương pháp **Quartile** và được chấm điểm từ 1 đến 4.

### Recency

Recency được chấm điểm theo chiều ngược vì giá trị Recency càng thấp càng thể hiện khách hàng giao dịch gần đây.

- Recency thấp → R_score cao
- Recency cao → R_score thấp

### Frequency và Monetary

Frequency và Monetary được chấm điểm theo chiều thuận:

- Giá trị thấp → Score thấp
- Giá trị cao → Score cao

Các điểm R, F và M sau đó được kết hợp để tạo thành **RFM Score** cho từng khách hàng.

## 5. Phân khúc khách hàng

Dựa trên RFM Score, khách hàng được phân thành 7 nhóm:

| Phân khúc     | Mô tả                                                          |
| ------------- | -------------------------------------------------------------- |
| VIP           | Khách hàng có mức độ tương tác và giá trị cao                  |
| THÂN THIẾT    | Khách hàng có mức độ gắn kết tốt và có thể tiếp tục phát triển |
| KHÔNG THỂ MẤT | Khách hàng có giá trị cao nhưng đã lâu chưa quay lại           |
| KHÁCH MỚI     | Khách hàng mới có hoạt động giao dịch                          |
| TIỀM NĂNG     | Khách hàng có dấu hiệu tích cực và có khả năng phát triển      |
| NGUY CƠ MẤT   | Khách hàng có dấu hiệu giảm mức độ tương tác                   |
| NGỦ ĐÔNG      | Khách hàng có mức độ tương tác và giá trị thấp                 |

Các phân khúc được sử dụng để phân tích giá trị khách hàng, mức độ tương tác và xác định cơ hội duy trì hoặc phát triển khách hàng.

---

## 6. Hạn chế của dữ liệu

- Dữ liệu giao dịch được sử dụng trong khoảng thời gian từ **06/2022 đến 08/2022**.
- Các chỉ số RFM và phân khúc khách hàng được tính toán dựa trên lịch sử giao dịch có trong khoảng thời gian phân tích.
- Vì vậy, kết quả phân tích cần được xem xét trong phạm vi dữ liệu hiện có.
