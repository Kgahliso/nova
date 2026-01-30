#!/bin/bash

# Footer HTML content to replace placeholder
FOOTER_CONTENT='  <footer class="footer overflow-hidden">
    <div class="b-container d-flex flex-column gap-4">
      <div class="row d-flex align-items-center gap-4 gap-xl-0">
        <div class="col-12 col-xl-6">
          <h3 class="text-secondary-color text-center text-xl-start mb-0" style="font-size: clamp(1.25rem, 3.5vw, 1.75rem); line-height: 1.4;">Stay updated with the latest solar innovations and news.</h3>
        </div>
        <div class="col-12 col-xl-6">
          <div class="d-flex flex-column">
            <div class="toast-container position-fixed bottom-0 end-0 p-3">
              <div id="liveToast" class="toast success_msg_subscribe text-bg-light" role="alert" aria-live="assertive"
                aria-atomic="true">
                <div class="d-flex">
                  <div class="toast-body">
                    <i class="bi bi-ch                    <i class="bi bi-ch                    <i class="bi bi-ch                    <i <button type="button" class="btn me-2 m-auto" data-bs-dismiss="toast" aria-label="Close">
                    <i clas                    <i clas                    <i cla                      <i clas                    <i clas                               <i clas  e needs-v                    <i clas                    <i clas                    <i cla                   ction" value="subscribe" hidden>
              <input type="email" name="email" id="email" class="form-control form-contr              <input type="email" aceh              <input type="email" name="e       <div class="invalid-feedback text-white">
                Please provide a valid email format (e.g.,
                user@example.com).
              </div>
              <button type="submi              <button type="submi ct              <butine-flex d-flex ali              <button type="submi        bmit_subscribe no-bottom-left-radius mt-3 mt-md-0">
                Subscribe Now
              </button>
            </form>
          </div>
        </div>
      </div>
      <hr class="py-2 text-heading-color-2 opacity-100">
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                  >
                                                                                                                                                                                                                          i></a>
            <div class="d-flex flex-column">
              <h6 class="text-secondary-c            mai           h6              <h6 class="text-secondary-c            main              <h6 class="text-secondary-c            mai           h6              <h6 class="text-secondary-c            main              <h6 class="text-secondary-c            mai           h6              <h6 class="text-secondary-c            main              <h6 class="text-secondary-c            mai           h6              <h6 class="text-secondary-c            main              <h6 class="text-secondary-c            mai           h6              <h6 class="text-secondary-c            main              <h6 class="text-secondary-c            mai           h6              <h6/div>
    <div class="row position-relative z-0">
      <div class="border-top-color position-relative z-1">
        <div class="b-container py-4">
          <div class="d-flex flex-column flex-md-row flex-wrap justify-content-center justify-content-md-between al          <div class="d-flex flex-colum="text          <div class="d-flex flex-column flex-md-row flex-wrap justify-content-center justify-content-md-between al          <div class="d-flex flex-colum="text          <div class="d-flex flex-column flex-md-row flex-wrap justify-content-center justify-content-md-between al          <div class="d-flex flex-colum="text          <div class="d-flex flex-column flex-md-row flex-wrap justify-content-center justify-content-md-between al          <div class="d-flex flex-colum="text          <div class="d-flex flex-column flex-md-row flex-wrap justify-content-center justify-content-md-between al          <div class="d-flex flex-colum="text          <div class="d-flex flex-column flex-md-row flex-wrap justify-content-cle..."
    # Use perl for more reliable multi-    # Use perl for more reliable multi-    # Use perl div i    # Use perl for more reliable multER_CONTENT"'|smg' "$file"
    
    # Remove load-footer.js script reference
    sed -i '' '/<script src=".*load-footer.js"><\/script>/d' "$file"
    sed -i '' '/<!-- Dynamic Footer Loader -->/d' "$file"
    
    echo "✓ $file updated"
  else
    echo "✗ $file not found"
  fi
done

echo ""
echo "All files updated successfully!"
