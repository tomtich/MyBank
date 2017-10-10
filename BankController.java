package com.banking.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.banking.model.Customer;
import com.banking.service.ProfileService;
import com.banking.upload.UploadItem;

@Controller
@RequestMapping("/uploadDocument")
public class BankController {
	
	@Autowired
	@Qualifier("ServiceImpl")
	private ProfileService profileService;
	private String uploadFolderPath;
	private BankController() {

	}

	
	// This method is used to add new Customer
	@RequestMapping(value = "uploadCustomer", method = RequestMethod.POST)
	public String uploadCustomer(@ModelAttribute Customer customer, Model model) {
		model.addAttribute("message",
				" &#9989; Hi " + customer.getName() + ", Your request was sent! we will notify you soon!");
		profileService.addCustomer(customer);

		return "Request";
	}

	
	//This method is used to delete a Customer in database
	@RequestMapping(value = "/{pk}", method = RequestMethod.DELETE, produces = { "application/json" })
	@ResponseBody
	public ApplicationMessageResponse deleteCustomer(@PathVariable("pk") long id) {
		String status = profileService.deleteCustomer(id);
		ApplicationMessageResponse applicationMessageResponse = new ApplicationMessageResponse();
		applicationMessageResponse.setStatus("success");
		applicationMessageResponse.setMessage("Profile data is deleted................");
		return applicationMessageResponse;
	}

	//This method will change status of Customer from Pending to Accepted 
	@RequestMapping(value = "/acceptCustomer/{pk}", method = RequestMethod.PUT, produces = { "application/json" })
	@ResponseBody
	public ApplicationMessageResponse acceptCustomer(@PathVariable("pk") long id) {

		String result = profileService.acceptCustomer(id);
		ApplicationMessageResponse applicationMessageResponse = new ApplicationMessageResponse();
		applicationMessageResponse.setStatus("success");
		applicationMessageResponse.setMessage("Profile data is accepted................");
		return applicationMessageResponse;

	}

	//This method will change status of Customer from Pending to Rejected
	@RequestMapping(value = "/rejectCustomer/{pk}", method = RequestMethod.PUT, produces = { "application/json" })
	@ResponseBody
	public ApplicationMessageResponse rejectCustomer(@PathVariable("pk") long id) {
		String result = profileService.rejectCustomer(id);
		ApplicationMessageResponse applicationMessageResponse = new ApplicationMessageResponse();
		applicationMessageResponse.setStatus("success");
		applicationMessageResponse.setMessage("Profile data is rejected................");
		return applicationMessageResponse;

	}
    
	//This method will show all Pending Customers
	@RequestMapping(value = "/customers", method = RequestMethod.GET, produces = { "application/json" })
	@ResponseBody
	public List<Customer> findCustomers() {
		List<Customer> customerList = profileService.showCustomer();
		return customerList;
	}

	
	
		
	// This part belong to upload file
	public String getUploadFolderPath() {
		return uploadFolderPath;
	}

	public void setUploadFolderPath(String uploadFolderPath) {
		this.uploadFolderPath = uploadFolderPath;
	}

	@RequestMapping(method = RequestMethod.GET)
	public String getUploadForm(Model model) {
		model.addAttribute(new UploadItem());
		return "/uploadDocument";
	}

	
	@RequestMapping(value="/upload", method = RequestMethod.POST)
	public String create(UploadItem uploadItem, BindingResult result, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		if (result.hasErrors()) {
			for (ObjectError error : result.getAllErrors()) {
				System.err.println("Error: " + error.getCode() + " - " + error.getDefaultMessage());
			}
			return "/uploadDocument";
		}

		// Some type of file processing...
		System.err.println("-------------------------------------------");
		try {
			MultipartFile file = uploadItem.getFileData();
			String fileName = null;
			InputStream inputStream = null;
			OutputStream outputStream = null;
			if (file.getSize() > 0) {
				inputStream = file.getInputStream();
				if (file.getSize() > 10000000) {
					System.out.println("File Size:::" + file.getSize());
					return "/uploadDocument";
				}
				System.out.println("size::" + file.getSize());
				fileName = "/Users/tritran/Documents/uploaddocument/" + file.getOriginalFilename();
				File f = new File(fileName);
				outputStream = new FileOutputStream(f);
				System.out.println("fileName:" + file.getOriginalFilename());

				int readBytes = 0;
				byte[] buffer = new byte[10000000];
				while ((readBytes = inputStream.read(buffer, 0, 10000000)) != -1) {
					outputStream.write(buffer, 0, readBytes);
				}
				outputStream.close();
				inputStream.close();
			}

			// ..........................................
			session.setAttribute("uploadFile", file.getOriginalFilename());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:uploadDocument";
	}

}
