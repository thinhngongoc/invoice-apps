document.addEventListener('DOMContentLoaded', function () {
    // --- Logic Đổi Mật khẩu Cá nhân ---
    const changePasswordForm = document.getElementById('changePasswordForm');

    if (changePasswordForm) {
        changePasswordForm.addEventListener('submit', async function (event) {
            event.preventDefault();

            const oldPassword = document.getElementById('oldPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmNewPassword = document.getElementById('confirmNewPassword').value;

            if (newPassword !== confirmNewPassword) {
                Swal.fire('Lỗi', 'Mật khẩu mới và xác nhận mật khẩu mới không khớp.', 'warning');
                return;
            }

            if (newPassword === oldPassword) {
                Swal.fire('Lỗi', 'Mật khẩu mới không được trùng với mật khẩu cũ.', 'warning');
                return;
            }

            if (newPassword.length < 6) {
                Swal.fire('Lỗi', 'Mật khẩu mới phải có ít nhất 6 ký tự.', 'warning');
                return;
            }

            try {
                const token = sessionStorage.getItem('access_token');
                if (!token) {
                    Swal.fire('Lỗi', 'Bạn chưa đăng nhập. Vui lòng đăng nhập lại.', 'error');
                    return;
                }

                const response = await fetch('/users/change-password', {
                    method: 'PUT',
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${token}`
                    },
                    body: JSON.stringify({
                        old_password: oldPassword,
                        new_password: newPassword,
                        confirm_new_password: confirmNewPassword
                    })
                });

                const data = await response.json();

                if (response.ok) {
                    Swal.fire('Thành công!', data.message || 'Mật khẩu đã được thay đổi.', 'success');
                    changePasswordForm.reset();
                    setTimeout(() => {
                        const modal = bootstrap.Modal.getInstance(document.getElementById('changePasswordModal'));
                        if (modal) modal.hide();
                    }, 1500);
                } else {
                    const errorMessage = data.detail || 'Đổi mật khẩu thất bại!';
                    Swal.fire('Lỗi', `Đổi mật khẩu thất bại: ${errorMessage}`, 'error');
                    console.error('Lỗi khi đổi mật khẩu (từ API):', data);
                }
            } catch (error) {
                console.error('Lỗi khi gửi yêu cầu đổi mật khẩu:', error);
                Swal.fire('Lỗi hệ thống', `Đã xảy ra lỗi mạng hoặc hệ thống: ${error.message}`, 'error');
            }
        });

        document.getElementById('changePasswordModal').addEventListener('hidden.bs.modal', function () {
            changePasswordForm.reset();
        });
    }

    // --- Logic Admin Đặt lại Mật khẩu Người dùng khác ---
    const adminResetPasswordForm = document.getElementById('adminResetPasswordForm');
    const adminResetPasswordModal = document.getElementById('adminResetPasswordModal'); // Lấy tham chiếu đến modal

    if (adminResetPasswordForm) {
        adminResetPasswordForm.addEventListener('submit', async function (event) {
            event.preventDefault(); // Ngăn form submit mặc định

            const targetUsername = document.getElementById('targetUsername').value;
            // ĐẢM BẢO ID TRÙNG VỚI HTML: adminNewPassword
            const newPasswordAdmin = document.getElementById('adminNewPassword').value; 
            // ĐẢM BẢO ID TRÙNG VỚI HTML: adminConfirmNewPassword
            const confirmNewPasswordAdmin = document.getElementById('adminConfirmNewPassword').value; 

            if (newPasswordAdmin !== confirmNewPasswordAdmin) {
                Swal.fire('Lỗi!', 'Mật khẩu mới và xác nhận mật khẩu mới không khớp.', 'warning');
                return;
            }

            if (newPasswordAdmin.length < 6) { // Kiểm tra độ dài mật khẩu
                Swal.fire('Lỗi!', 'Mật khẩu mới phải có ít nhất 6 ký tự.', 'warning');
                return;
            }

            const token = sessionStorage.getItem('access_token');
            if (!token) {
                Swal.fire('Lỗi!', 'Không tìm thấy token xác thực. Vui lòng đăng nhập lại.', 'error');
                return;
            }

            try {
                const response = await fetch('/users/admin-reset-password', {
                    method: 'PUT', // Đúng phương thức PUT
                    headers: {
                        'Content-Type': 'application/json',
                        'Authorization': `Bearer ${token}`
                    },
                    body: JSON.stringify({
                        target_username: targetUsername,
                        new_password: newPasswordAdmin, // Gửi biến đã lấy đúng ID
                        confirm_new_password: confirmNewPasswordAdmin // Gửi biến đã lấy đúng ID
                    })
                });

                const data = await response.json();

                if (response.ok) {
                    Swal.fire('Thành công!', data.message || 'Mật khẩu người dùng đã được đặt lại.', 'success');
                    adminResetPasswordForm.reset(); // Xóa form
                    if (adminResetPasswordModal) {
                        const modal = bootstrap.Modal.getInstance(adminResetPasswordModal);
                        if (modal) modal.hide(); // Đóng modal
                    }
                } else {
                    const errorMessage = data.detail || 'Có lỗi xảy ra khi đặt lại mật khẩu.';
                    if (Array.isArray(data.detail)) { // Xử lý lỗi trả về từ Pydantic (validation errors)
                        const details = data.detail.map(err => `${err.loc.join('.')} - ${err.msg}`).join('\n');
                        Swal.fire('Lỗi', `Đặt lại mật khẩu thất bại:\n${details}`, 'error');
                        console.error('Lỗi khi đặt lại mật khẩu (từ API - chi tiết):', data.detail);
                    } else {
                        Swal.fire('Lỗi!', `Đặt lại mật khẩu thất bại: ${errorMessage}`, 'error');
                        console.error('Lỗi khi đặt lại mật khẩu (từ API):', data);
                    }
                }
            } catch (error) {
                console.error('Lỗi khi gửi yêu cầu đặt lại mật khẩu:', error);
                Swal.fire('Lỗi hệ thống', `Đã xảy ra lỗi mạng hoặc hệ thống: ${error.message}`, 'error');
            }
        });

        // Đặt lại form khi modal đóng
        if (adminResetPasswordModal) {
            adminResetPasswordModal.addEventListener('hidden.bs.modal', function() {
                adminResetPasswordForm.reset();
            });
        }
    }
});