*** Settings ***
Documentation       View X-ray images.
...                 Inspired by the original example at
...                 https://numpy.org/numpy-tutorials/content/tutorial-x-ray-image-processing.html

Library             RPA.Dialogs
Library             xray.py


*** Variables ***
${OP_CANNY_FILTER}=             Canny filter
${OP_GAUSSIAN_GRADIENT}=        Gaussian Gradient (edges)
${OP_LAPLACIAN_GAUSSIAN}=       Laplacian Gaussian (edges)
${OP_SOBEL_FELDMAN}=            Sobel-Feldman operator
${OP_VIEW}=                     View


*** Tasks ***
View X-ray image
    ${image_path}    ${operation}=    Select X-ray images and operation
    IF    "${operation}" == "${OP_VIEW}"
        Display Xray    ${image_path}
    ELSE IF    "${operation}" == "${OP_CANNY_FILTER}"
        Display Canny Filter    ${image_path}
    ELSE IF    "${operation}" == "${OP_GAUSSIAN_GRADIENT}"
        Display Gaussian Gradient    ${image_path}
    ELSE IF    "${operation}" == "${OP_LAPLACIAN_GAUSSIAN}"
        Display Laplacian Gaussian    ${image_path}
    ELSE IF    "${operation}" == "${OP_SOBEL_FELDMAN}"
        Display Sobel Feldman    ${image_path}
    END


*** Keywords ***
Select X-ray images and operation
    Add file input
    ...    name=xray_image
    ...    source=%{ROBOT_ROOT}${/}x-ray-images
    Add operation options
    ${result}=    Run dialog    title=X-ray Image Viewer
    RETURN    ${result.xray_image}[0]    ${result.operation}

Add operation options
    ${options}=
    ...    Create List
    ...    ${OP_VIEW}
    ...    ${OP_CANNY_FILTER}
    ...    ${OP_GAUSSIAN_GRADIENT}
    ...    ${OP_LAPLACIAN_GAUSSIAN}
    ...    ${OP_SOBEL_FELDMAN}
    Add Radio Buttons
    ...    name=operation
    ...    options=${options}
    ...    default=${OP_VIEW}
