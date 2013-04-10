package org.thorn.workflow.entity;
/** 
 * @ClassName: ProcessDefinition 
 * @Description: 
 * @author chenyun
 * @date 2012-6-17 下午03:38:55 
 */
public class ProcessDefinition implements org.jbpm.api.ProcessDefinition {
	
	/** */
	private static final long serialVersionUID = -7933555545998939345L;
	
	private String id;
	
	private String name;
	
	private String key;
	
	private int version;
	
	private String deploymentId;
	
	private String imageResourceName;
	
	private String description;
	
	private boolean suspended;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public int getVersion() {
		return version;
	}

	public void setVersion(int version) {
		this.version = version;
	}

	public String getDeploymentId() {
		return deploymentId;
	}

	public void setDeploymentId(String deploymentId) {
		this.deploymentId = deploymentId;
	}

	public String getImageResourceName() {
		return imageResourceName;
	}

	public void setImageResourceName(String imageResourceName) {
		this.imageResourceName = imageResourceName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public boolean isSuspended() {
		return suspended;
	}

	public void setSuspended(boolean suspended) {
		this.suspended = suspended;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}

